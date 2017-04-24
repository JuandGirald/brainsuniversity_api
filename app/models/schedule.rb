class Schedule < ApplicationRecord
  before_create :set_default_status 
  before_validation :set_free_duration

  belongs_to :teacher, inverse_of: :schedules
  delegate :email, to: :teacher, prefix: true

  belongs_to :student, inverse_of: :schedules
  has_one :room, inverse_of: :schedule
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

  # Create a room for the current schedule with
  # OpenTok credentials
  #
  def generate_room
    opentok = OpentokApi.new
    session = opentok.create_session

    teacher_token = opentok.get_user_token(self.teacher, self, session.session_id)
    student_token = opentok.get_user_token(self.student, self, session.session_id)

    create_room(teacher_token: teacher_token, 
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
