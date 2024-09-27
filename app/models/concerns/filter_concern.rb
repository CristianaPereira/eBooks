module FilterConcern
  extend ActiveSupport::Concern

  included do
    # do i need this?
    # class_attribute :query_scope
    class_attribute :filter_scopes_module
  end

  class_methods do
    # def concern_filter(**filters)
    #   res = query_scope.all
    #   filters.each do |key, value|
    #     scope_filter = "by_#{key}"
    #     res = res.send(scope_filter, filters[key]) if filter_scopes_module.respond_to?(scope_filter)
    #   end
    #   res
    # end
    #
    def concern_filter(**filters)
      res = all
      filters.each do |key, value|
        scope_filter = "by_#{key}"
        res = res.send(scope_filter, filters[key]) if respond_to?(scope_filter)
      end
      res
    end
  end
end
