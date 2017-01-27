module Api::V1
  class StudentsController < ApiController
  	include Api::V1::StudentsDoc

    skip_before_action :authenticate!, only: [:create]
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users/1
    def show
      render json: @user
    end

    # POST /users
    def create
      @user = Student.new(user_params)

      if @user.save
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = Student.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:student).permit(:password, :email)
      end
  end
end