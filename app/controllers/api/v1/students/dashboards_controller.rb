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
      render :json => { :schedules => @schedules, 
                        :teachers => @teachers }
    end
  end
end
