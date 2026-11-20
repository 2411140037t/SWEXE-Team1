class UserController < ApplicationController
  before_action :redirect_if_logged_in

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.expect(user: [:name, :nickname, :email, :password, :password_confirmation]))

    if @user.save
      reset_session
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end
