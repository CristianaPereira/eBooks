class SessionsController < ApplicationController
  include CurrentUserConcern

  def login
    user = User.find_by(email: params["email"]).try(:authenticate, params["password"])
    if user
      session[:user_id] = user.id
      render json: { status: :ok, logged_in: true, user: user }
    else
      # TODO: deal with error
      render json: { status: 401 }
    end
  end

  def logged_in
    if @current_user
      render json: { logged_in: true, user: @current_user }
    else
      render json: { logged_in: false }
    end
  end

  def logout
    reset_session
    render json: { status: 200, logged_out: true }
  end
end
