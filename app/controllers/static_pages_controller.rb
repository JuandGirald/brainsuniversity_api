class StaticPagesController < ActionController::Base
  def home
  end

  def thanks
    @user = User.find(params[:id])
  end

  def check_status
    render json: true
  end

  def invalid_activation_token
  end

  def respuesta
    
  end

end