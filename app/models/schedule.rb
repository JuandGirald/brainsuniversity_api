class Schedule < ApplicationRecord
  include AASM
  # before_create :set_default_status 
  before_validation :set_free_duration

  belongs_to :teacher, inverse_of: :schedules
  delegate :email, to: :teacher, prefix: true

  belongs_to :student, inverse_of: :schedules
  has_one :room, inverse_of: :schedule
  has_one :order
  delegate :email, to: :student, prefix: true

  validates :teacher, :student, presence: true
  validates :start_at, :duration, presence: true

  enum status: { awaiting_tutor: '1', 
                 accepted_awaiting_payment: '2',
                 confirmed: '3',
                 rejected: '4',
                 expired: '5',
                 canceled: '6',
                 completed: '7'
               }

  # state machine methods
  aasm :column => :status do
    state :awaiting_tutor, :initial => true
    state :accepted_awaiting_payment, :confirmed, :expired, :canceled,
          :rejected, :completed

    event :accepted_awaiting_payment do
      after do
        create_order
      end
      transitions :from => :awaiting_tutor, :to => :accepted_awaiting_payment
    end

    event :awaiting_tutor do
      transitions :from => [:expired, :accepted_awaiting_payment,
                            :canceled, :rejected], 
                            :to => :awaiting_tutor
    end
    
    event :confirmed do
      transitions :from => [:awaiting_tutor, :accepted_awaiting_payment], :to => :confirmed
    end

    event :rejected do
      transitions :from => [:awaiting_tutor, :accepted_awaiting_payment], :to => :rejected
    end

    event :expired do
      transitions :from => [:awaiting_tutor, :accepted_awaiting_payment], :to => :expired
    end

    event :canceled do
      transitions :from => [:awaiting_tutor, :accepted_awaiting_payment], :to => :canceled
    end

    event :completed do
      transitions :from => [:confirmed], :to => :completed
    end
  end

  def create_order
    if self.order.nil? || self.order.total.nil?
      order.generate_order_number
      order.attributes = { total: calculate_order, 
        currency: "cop", hour: (duration.to_f/600).to_s, 
        title: "Tutoria con #{teacher.first_name} #{teacher.last_name}", 
        description: "Tutoria personalizada dentro de la plataforma de brainstutor por #{duration.to_i/60} minutos" 
      }
      order.save!
    end
  end

  def calculate_order
    teacher.profile.rate * ( duration.to_f/3600 )
  end

  # Create a room for the current schedule with
  # OpenTok credentials
  #
  def generate_room
    opentok = OpentokApi.new
    session = opentok.create_session

    teacher_token = opentok.get_user_token(self.teacher, self, session.session_id)
    student_token = opentok.get_user_token(self.student, self, session.session_id)

    create_room(
                name: teacher.first_name,
                teacher_token: teacher_token, 
                student_token: student_token,
                session_id: session.session_id
               )
  end
  
  private

    def set_default_status
      self.status = 'awaiting_tutor'
    end

    def set_free_duration
      self.duration = 15.minutes if modality == 'free'
    end
end
