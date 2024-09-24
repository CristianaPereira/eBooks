class Api::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    render json: User.all, status: :ok
  end

  # GET /users/1
  def show
    # TODO: exclude password
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.create!(user_params)
    # TODO: handle password_confirmation
    render json: @user.as_json(except: [ :password_digest ]), status: :created
  end

  # PATCH/PUT /users/1
  def update
    @user.update!(user_params)
    # TODO: DRY on to_json
    render json: @user.as_json(except: [ :password_digest ]), status: :ok
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
      puts request
      params.require(:user).permit(:name, :username, :email, :password, :user_type_id)
    end
end
