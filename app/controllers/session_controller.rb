class SessionController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      reset_session
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが違います"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to login_path, status: :see_other
  end
end