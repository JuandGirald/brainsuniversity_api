module Api::V1
  class Teachers::DashboardsController < ApiController
    def index
      @students = current_user.students.joins(:profile).
                                        select(:id, :email, :university,
                                              :first_name, :last_name)
      @schedules = current_user.schedules.
                   joins(:student).
                   select_fields.
                   upcoming_teacher
      @messages = current_user.current_chats.
                              unread.
                              joins(:messages, :sender).
                              distinct.
                              select(:id, :first_name, :last_name, :email, "chats.readed", "chats.updated_at")
      render 'api/v1/teachers/dashboards/index.json.jbuilder'                              
    end
  end
end
