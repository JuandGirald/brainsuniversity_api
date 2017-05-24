module Api::V1
  class ChatsController < ApiController
    def index
    	render json: current_user.current_chats
    end
  end
end