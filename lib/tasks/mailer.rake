# file: lib/tasks/scheduler_tasks.rake
require 'action_view'
include ActionView::Helpers::DateHelper

desc 'send email to all accepted tutors'
task send_email_to_accepted_tutors: :environment do
  
  Teacher.accepted.each do |t|
    UserMailer.accepted_tutor(t).deliver_now
  end
end