# file: lib/tasks/scheduler_tasks.rake
require 'action_view'
include ActionView::Helpers::DateHelper

desc 'create a room for schedules with OpenTok sections'
task create_room: :environment do
  regex = /minute/

  Schedule.confirmed.each do |s|
    t = distance_of_time_in_words(Time.now, s.start_at)


    if !(regex =~ t).nil?  && t.to_i <= 10
      unless s.room.present?
        s.generate_room
      end
    end
  end
end

desc 'check expired schedules'
task expired_schedules: :environment do
  schedules = Schedule.where(status: [:awaiting_tutor, :accepted_awaiting_payment])

  schedules.each do |s|
    if Time.now > s.start_at
      s.expired!
    end
  end
end