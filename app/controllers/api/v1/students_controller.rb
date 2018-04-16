module Api::V1
  class StudentsController < ApiController
  	include Api::V1::StudentsDoc
    include ErrorSerializer

    load_and_authorize_resource except: [:create]
    skip_before_action :authenticate_request, only: [:create]
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users/1
    def show
      render json: @user
    end

    #GET /Users
    def index
      @user = current_user
      render json: @user, serializer: IndexStudentSerializer
    end

    # POST /users
    def create
      @user = Student.new(student_params)

      if @user.save
        UserMailer.account_activation(@user).deliver_now
        render json: @user, serializer: NewUsersSerializer
      else
        render json: ErrorSerializer.serialize(@user.errors), status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(student_params)
        render json: @user
      else
        render json: ErrorSerializer.serialize(@user.errors), status: :unprocessable_entity
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = Student.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def student_params
        params.require(:student).permit(:id, :password, :email, :first_name, :last_name,
                                        profile_attributes: [:id, :university, :dob, :phone, 
                                                         :address, :gender, :city, :country,
                                                         :level, :about, :rate, :student_id, :_destroy]
                                        )
      end
  end
end