class ApplicationController < ActionController::API
  # TODO: investigate
  # skip_before_action :verify_authenticity_token
  before_action :handle_cookies


  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def record_not_found
    render json: { error: "record_not_found" }, status: :not_found  # 404 to be handle in front with more details
  end


  def record_invalid(invalid)
    puts invalid.record.errors
    render json: { error: "record_invalid", record_errors: invalid.record.errors }, status: :unprocessable_entity
  end
  def handle_cookies
    puts "-----handle_cookies----"
    puts request.cookies
  end
end
