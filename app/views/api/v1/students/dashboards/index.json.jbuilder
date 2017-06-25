json.schedules @schedules.each do  |schedule|
  json.(schedule, :id, :status, :start_at, :modality, 
                  :duration, :first_name, :last_name, :email)
  json.order Schedule.find(schedule.id).order
end
json.messages @messages.each do |message|
  json.(message, :id, :first_name, :last_name, 
                  :email, :readed, :updated_at)
  json.last_message message.messages.last.body
end
json.(@teachers, :teacher)
