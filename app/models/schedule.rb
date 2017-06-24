class Schedule < ApplicationRecord
  include AASM
  before_create :schedule_mailing, :add_teacher_to_student
  before_validation :set_free_duration

  belongs_to :teacher, inverse_of: :schedules
  delegate :email, to: :teacher, prefix: true

  belongs_to :student, inverse_of: :schedules
  has_one :room, inverse_of: :schedule
  has_one :order
  delegate :email, to: :student, prefix: true

  validates :teacher, :student, presence: true
  validates :start_at, :duration, presence: true

  scope :upcoming_teacher, -> { awaiting_tutor + confirmed.where("start_at > ?", Date.today) }
  scope :upcoming_student, -> { accepted_awaiting_payment + confirmed.where("start_at > ?", Date.today) }

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

    after_all_transitions :schedule_mailing

    event :accepted_awaiting_payment do
      after do
        generate_order
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

  def schedule_mailing
    state = aasm.to_state || status
    ScheduleMailer.send(state, self).deliver_now
  end

  def generate_order
    if order.nil? || order.total.nil? || (aasm.to_state == :accepted_awaiting_payment)
      build_order if order.nil?
      order.generate_order_number
      order.attributes = { total: calculate_order, 
        currency: "cop", hour: (duration.to_f/60).to_s, 
        title: "Tutoria con #{teacher.first_name} #{teacher.last_name}", 
        description: "Tutoria personalizada dentro de la plataforma de brainstutor por #{duration.to_i} minutos" 
      }
      order.save!
    end
  end

  def calculate_order
    teacher.profile.rate * ( duration.to_f/60 )
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

    def add_teacher_to_student
      student.teachers << teacher
      student.save
    end

    def set_free_duration
      self.duration = "10" if modality == 'free'
    end
end
