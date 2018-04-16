class Teacher < User
  before_create :set_role, :set_status
  after_create  :set_bank_information_availability
  # after_update  :accepted_tutor
  
  has_many :teacher_students
  has_many :students, through: :teacher_students 
  has_one :profile, inverse_of: :teacher
  has_one :bank_information
  has_one :availability
  has_many :schedules, inverse_of: :teacher
  accepts_nested_attributes_for :profile, :availability

  enum status: { pending: '1', 
                 accepted: '2',
                 rejected: '3',
                 waiting: '4',
                 complete: '5'
               }

  # set the user to wait for approval
  # send email to schedule an appointment
  #
  def schedule_step
    self.waiting!
    UserMailer.schedule_step(self).deliver_now
  end

  # send email when a tutor is accepted
  # 
  def accepted_tutor
    if waiting?
      UserMailer.accepted_tutor(self).deliver_now if waiting?
      self.accepted!
    end
  end

  # fix ActiveRecord + problem withe arrays
  # when udate data
  # 
  def update_subjects(array)
    self.subjects = array.split(',')
    subjects_will_change!
    self.save!
  end

  # Parse availability array params 
  #
  def parse_availability_params(params)
    params.each do |param|
      unless param == 'id'
        parsed = JSON.parse params[param] 
        param = param + "="
        self.availability.send(param, parsed) 
      end
    end
    self.save!
  end
  
  private
    def set_bank_information_availability
      create_bank_information 
      create_availability
    end

    def set_role
      self.role = 'teacher'
    end

    def set_status
      self.status = 'pending'
    end
end