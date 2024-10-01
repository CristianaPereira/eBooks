class ApplicationService
  class << self
    def call(*args, **kwargs, &block)
      new.call(*args, **kwargs, &block)
    end
  end
end
