module MessageMethods
  extend ActiveSupport::Concern

  def send_schedule_message(message, schedule)
    teacher = schedule.teacher
    student = schedule.student
    
    if Chat.between(student, teacher).present?
      chat = Chat.between(student, teacher).first
    else
      chat = Chat.create(sender_id: student.id, 
                         recipient_id: teacher.id
                        )
    end

    message = chat.messages.build(body: message)
    message.user_id = current_user.id
    message.save!
  end
end