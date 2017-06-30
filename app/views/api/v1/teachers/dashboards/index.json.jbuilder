json.schedules @schedules.each do  |schedule|
  json.(schedule, :id, :status, :modality, 
                  :duration, :first_name, :last_name, :email)
  json.teacher_id Schedule.find(schedule.id).student.id
  json.start_at schedule.start_at.to_formatted_s(:short)
  json.order Schedule.find(schedule.id).order
end
json.messages @messages.each do |message|
  json.(message, :id, :first_name, :last_name, 
                  :email, :readed)
  json.last_message message.messages.last.body
  json.updated_at message.updated_at.to_formatted_s(:short)
end
json.students @students
