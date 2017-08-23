module Api::V1
  class Students::SchedulesController < ApiController
    include ErrorSerializer
    include MessageMethods
    load_and_authorize_resource

    before_action :set_schedule, only: [:update, :show, :session, :apply_promo]

    def index
      page = params[:page].present? ? params[:page] : 1 
      if params[:status].present?
        @schedules = current_user.schedules.send(params[:status])
      else
        @schedules = current_user.schedules
      end
      @schedules = @schedules.paginate(page: page, :per_page => 10).order('start_at ASC')
      render json: @schedules, each_serializer: ListSchedulesSerializer,
                               meta: pagination(@schedules, 10)
    end

    def session
      if @schedule.room.present?
        render json: { apikey: ENV['OPENTOK_API_KEY'],
                       sessionId: @schedule.room.session_id,
                       token: @schedule.room.student_token,
                       duration: @schedule.duration.to_i * 60
                     }
      else
        render json: { error: "Tu tutoria no estará disponible hasta el: #{@schedule.start_at.to_formatted_s(:short)}" }
      end
    end

    def show
      render json: @schedule, serializer: ScheduleSerializer
    end

    def create
      @schedule = current_user.schedules.create(schedule_params)

      if @schedule.save
        send_schedule_message(params[:schedule][:message], @schedule) if params[:schedule][:message]
        render json: @schedule, serializer: ScheduleSerializer
      else
        render json: ErrorSerializer.serialize(@schedule.errors), status: :unprocessable_entity
      end
    end

    def update
      if @schedule.update_attributes(schedule_params)
        send_schedule_message(params[:schedule][:message], @schedule) if params[:schedule][:message]
        @schedule.send(params[:schedule][:status] + '!') if params[:schedule][:status]
        render json: @schedule, serializer: ScheduleSerializer
      else
        render json: ErrorSerializer.serialize(@schedule.errors), status: :unprocessable_entity
      end
    end

    def apply_promo
      @student_coupon = current_user.student_coupons.find_student_coupon(params[:coupon_id])

      @schedule.apply_coupon(@student_coupon) if @student_coupon
      if !@schedule.errors.present?
        render json: { coupons: "YAY! Promoción aplicada con éxito! ", status: :success } 
      else
        render json: ErrorSerializer.serialize(@schedule.errors), status: :unprocessable_entity
      end
    end

    private
      def schedule_params
        params.require(:schedule).permit(:id, :start_at, :end_at, :duration, :modality, 
                                         :student_id, :teacher_id)
      end

      def set_schedule
        @schedule = current_user.schedules.find(params[:id])
      end
  end
end
