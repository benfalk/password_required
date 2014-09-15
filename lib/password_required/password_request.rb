module PasswordRequired
  class PasswordRequest
    include ActiveModel::Model

    delegate :env, :parameters, to: :@request

    attr_accessor :password

    def initialize(request)
      @request = request
      super({})
    end

    def target_url
      env['ORIGINAL_FULLPATH']
    end
  end
end
