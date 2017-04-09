module Api::V1
  class Students::SchedulesController < ApiController
    load_and_authorize_resource

    before_action :set_schedule, only: [:update, :show]

    def index
      page = params[:page].present? ? params[:page] : 1 
      if params[:status].present?
        @schedules = current_user.schedules.send(params[:status])
      else
        @schedules = current_user.schedules
      end
      render json: @schedules.paginate(page: page, :per_page => 10), each_serializer: ListSchedulesSerializer
    end

    def show
      render json: @schedule, serializer: ScheduleSerializer
    end

    def create
      @user = current_user.schedules.create(schedule_params)
      if @user.save
        render json: @user, serializer: ScheduleSerializer
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def update
      if @schedule.update_attributes(schedule_params)
        render json: @schedule, serializer: ScheduleSerializer
      else
        render json: @schedule.errors, status: :unprocessable_entity
      end
    end

    private
      def schedule_params
        params.require(:schedule).permit(:id, :start_at, :end_at, 
                                         :status, :duration, :modality, 
                                         :student_id, :teacher_id)
      end

      def set_schedule
        @schedule = current_user.schedules.find(params[:id])
      end
  end
end
