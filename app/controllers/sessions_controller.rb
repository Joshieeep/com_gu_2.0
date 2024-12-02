class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate_by(email: params[:email], password: params[:password])

    if user
      login user

      # Handle "Remember me?" functionality
      if params[:remember_me] == "1"
        cookies.permanent.signed[:user_id] = user.id
      else
        cookies.delete(:user_id)
      end

      redirect_to root_path, notice: "You have signed in successfully"
    else
      flash[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout current_user
    cookies.delete(:user_id) # Clear the persistent cookie upon logout
    redirect_to root_path, notice: "You have been logged out."
  end
end
