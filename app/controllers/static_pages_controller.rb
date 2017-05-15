class StaticPagesController < ActionController::Base
  def home
  end

  def thanks
    @user = User.find(params[:id])
  end

  def invalid_activation_token
  end

end