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
      render :json => { :schedules => @schedules, 
                        :students => @students }
    end
  end
end
