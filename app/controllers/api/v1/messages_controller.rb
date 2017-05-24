module Api::V1
  class MessagesController < ApiController
    
    def index
      @chat = Chat.find(params[:chat_id])
      render json: @chat.messages
    end

    def create
      if Chat.between(current_user, params[:chat][:recipient_id]).present?
        @chat = Chat.between(current_user, params[:chat][:recipient_id]).first
      else
        @chat = current_user.chats.create(chat_params)
      end
        
      @message = @chat.messages.build(message_params)
      @message.user_id = current_user.id
      
      if @message.save!
          render json: @message
      else
        render json: @message.errors
      end
    end

    private
    def chat_params
      params.require(:chat).permit(:recipient_id)
    end

    def message_params
      params.require(:message).permit(:body, :user_id)
    end
  end
end

