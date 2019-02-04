module Services
  class UniqueIdGenerator
    def call
      Time.current.strftime("%H%M%S%L#{SecureRandom.random_number(100)}")
    end
  end
end