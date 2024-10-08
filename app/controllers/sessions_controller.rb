class SessionsController < ApplicationController
  include CurrentUserConcern

  def login
    user = User.find_by(email: params["email"].downcase).try(:authenticate, params["password"])
    if user
      session[:user_id] = user.id
      render json: { logged_in: true, user: user }, status: :ok
    else
      # TODO: deal with error
      render json: {}, status: 401
    end
  end

  def logged_in
    if @current_user
      render json: { logged_in: true, user: @current_user }, status: :ok
    else
      render json: { logged_in: false }, status: :ok
    end
  end

  def logout
    reset_session
    render json: { logged_in: false }, status: :ok
  end
end
