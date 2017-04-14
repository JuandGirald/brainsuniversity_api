module Api::V1
  class TeachersController < ApiController
    include Api::V1::TeachersDoc

    load_and_authorize_resource only: [:update]
    skip_before_action :authenticate_request, only: [:create, :index, :show]
    before_action :set_user, only: [:show, :update]

    # GET /teachers/1
    def show
      render json: @user, serializer: UserProfileSerializer
    end

    # GET /teachers
    def index
      page = params[:page].present? ? params[:page] : 1 
      @users = Teacher.complete

      if params[:subject].present?
        @users = @users.where('subjects && ARRAY[?]::varchar[]', params[:subject])
      end

      @users = @users.paginate(page: page, :per_page => 10)
      render json: @users, meta: pagination(@users, 10)
    end

    # POST /teachers
    def create
      @user = Teacher.new(teacher_params)

      if @user.save
        UserMailer.account_activation(@user).deliver_now
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /teachers/1
    def update
      if @user.update(teacher_params)
        @user.schedule_step if @user.pending?
        render json: @user, serializer: UserProfileSerializer
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = Teacher.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def teacher_params
        params.require(:teacher).permit(:id, :password, :email, :first_name, :last_name, :subjects,
                                        profile_attributes: [:id, :university, :dob, :phone, 
                                                         :address, :gender, :city, :country,
                                                         :level, :about, :rate, :teacher_id, :_destroy],
                                        availability_attributes: [:id, :teacher_id, :morning, :evening,
                                                                  :afternoon, :night]
                                        )
      end
  end
end