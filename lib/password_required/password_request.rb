module PasswordRequired
  class PasswordRequest
    delegate :env, :parameters, to: :@request

    def initialize(request)
      @request = request
    end
  end
end
