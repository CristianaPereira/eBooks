module CurrentUserConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  def set_current_user
    puts "SET CURRENT USER"
    puts "LOGGED IN"
     if request.cookies["ebooks_session_id"]
      # TODO: handle cookie and sessions table
      @current_user = User.first
     end
  end
end
