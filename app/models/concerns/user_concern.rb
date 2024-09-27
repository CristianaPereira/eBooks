module UserConcern
  extend ActiveSupport::Concern

  included do
    scope :by_c_username, ->(username) { where("username LIKE ?", "%#{username}%") if username.present? }
  end

  def concern_i_hi
    puts "Hi from concern instance"
  end


  class_methods do
    def concern_c_hi; concern_private_hi; end


    def concern_filter(**filters)
      puts filters
      res = all
      # filters.each do |key, value|
      #   puts key
      #   puts value
      #   # res = res.send(key, value) if respond_to?(key)
      # end
      res = res.send(:by_name, filters[:name]) if respond_to?(:by_name)
      res = res.send(:by_c_username, filters[:username]) if respond_to?(:by_c_username)
      # by_name(name).by_c_username(username)
      # send(:by_name, filters[:name]).send(:by_c_username, filters[:username])
      respond_to?(:by_name)
      respond_to?(:by_c_username)
      res
    end

    def filter_by(**filters)
      puts filters
    end
    # extend model class scope with filter methods
    # extended_scope = query_scope.extending(filter_scopes_module)

    # The payload for filters will be a hash. Each key will have the
    # name of a filter scope. We will map each key value pair to its
    # respective filter scope.
    # filters.each do |filter_scope, filter_value|
    #   if filter_value.present? && extended_scope.respond_to?(filter_scope)
    #     extended_scope = extended_scope.send(filter_scope, filter_value)
    #   end
    # end


    private
      def concern_private_hi; puts "Hi from concern"; end
  end
end
