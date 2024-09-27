# file name must be equal to module name
module Filterable
  extend ActiveSupport::Concern

  class_methods do
    def filter(filters)
      res = all
      filters.each do |key, value|
        scope_filter = "by_#{key}"
        res = res.send(scope_filter, filters[key]) if respond_to?(scope_filter)
      end
      res
    end
  end
end
