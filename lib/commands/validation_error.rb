module Commands
  class ValidationError < StandardError
    attr_accessor :message, :custom_error

    def initialize(message, custom_error = nil)
      @message = message
      @custom_error = custom_error
    end
  end
end
