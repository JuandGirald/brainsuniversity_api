module Api::V1
  class TeachersController < ApiController
  	include Api::V1::TeachersDoc

    load_and_authorize_resource only: [:update]
    skip_before_action :authenticate_request, only: [:create, :index]
    before_action :set_user, only: [:show, :update]

    # GET /teachers/1
    def show
      render json: @user
    end

    # GET /teachers
    def index
      @users = Teacher.all

      render json: @users
    end

    # POST /teachers
    def create
      @user = Teacher.new(teacher_params)

      if @user.save
        UserMailer.account_activation(@user).deliver_now
        render json: @user, serializer: NewUsersSerializer
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /teachers/1
    def update
      if @user.update(teacher_params)
        render json: @user
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
        params.require(:teacher).permit(:password, :email)
      end
  end
end