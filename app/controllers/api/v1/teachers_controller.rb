module Api::V1
  class TeachersController < ApiController
  	include Api::V1::TeachersDoc

    load_and_authorize_resource
    skip_before_action :authenticate!, only: [:create]
    before_action :set_user, only: [:show, :update]

    # GET /users/1
    def show
      render json: @user
    end

    # POST /users
    def create
      @user = Teacher.new(teacher_params)

      if @user.save
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
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