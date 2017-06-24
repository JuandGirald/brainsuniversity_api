module Api::V1
  class Teachers::DashboardsController < ApiController
    def index
      @students = current_user.students.joins(:profile).
                                        select(:id, :email, :university,
                                              :first_name, :last_name)
      render :json => { :schedules => current_user.schedules.upcoming_teacher , 
                        :students => @students }
    end
  end
end
