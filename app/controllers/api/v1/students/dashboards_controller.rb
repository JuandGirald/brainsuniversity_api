module Api::V1
  class Students::DashboardsController < ApiController
    def index
      @teachers = current_user.teachers.joins(:profile).
                                        select(:id, :email, :first_name, :last_name,
                                               :university, :rate, :subjects)
      render :json => { :schedules => current_user.schedules.upcoming_student, 
                        :teachers => @teachers }
    end
  end
end
