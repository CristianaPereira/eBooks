class Api::UsersController < ApplicationController
  skip_before_action :ensure_is_logged_in, only: %i[create]
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    render json: User.filter(filter_params), status: :ok
  end

  # GET /users/1
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.create!(user_params)
    # TODO: handle password_confirmation
    save_base64_avatar
    session[:user_id] = @user.id
    render json: @user, status: :created
  end


  def save_base64_avatar
    return unless params[:user][:avatar].present?
    base64_file = params[:user][:avatar]
    @user.attach_file!(base64_file, :avatar, avatar_file_key)
  end

  # PATCH/PUT /users/1
  def update
    @user.update!(user_params)
    render json: @user, status: :ok
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
    render json: {},  status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      # distinguish between action
      if params[:action] ==  "update"
         params.require(:user).permit(:name)
      elsif params[:action] == "create"
        params.require(:user).permit(:name, :username, :email, :password)
      end
    end

    def filter_params
      params.permit(:name, :username)
    end

    def avatar_file_key
      "#{Rails.env}/users/#{@user[:id]}/"
    end
end
