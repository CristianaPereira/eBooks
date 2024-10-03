class ApplicationController < ActionController::API
  include CurrentUserConcern

  # TODO: investigate
  # skip_before_action :verify_authenticity_token
  before_action :ensure_is_logged_in

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from RuntimeError, with: :runtime_error

  def record_not_found
    render json: { error: "record_not_found" }, status: :not_found  # 404 to be handle in front with more details
  end

  def record_invalid(invalid)
    render json: { error: "record_invalid", record_errors: invalid.record.errors }, status: :unprocessable_entity
  end

  def runtime_error(error)
    render json: { error: "runtime_error", message: "Ups something happened" }, status: :unprocessable_entity
  end

  def ensure_is_logged_in
    unless session[:user_id]
      render json: { error: "not_logged_in" }, status: :unauthorized
    end
  end
end
