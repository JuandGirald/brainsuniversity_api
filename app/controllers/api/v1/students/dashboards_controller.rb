module Api::V1
  class Students::DashboardsController < ApiController
    def index
      @teachers = current_user.teachers.joins(:profile).
                                        select(:id, :email, :first_name, :last_name,
                                               :university, :rate, :subjects)
      @schedules = current_user.schedules.
                   joins(:teacher).
                   select_fields.
                   upcoming_student 
      @messages = current_user.current_chats.
                              unread.
                              joins(:messages, :recipient).
                              distinct.
                              select(:id, :first_name, :last_name, :email, "chats.readed", "chats.updated_at")
    end
  end
end
