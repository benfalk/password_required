require 'password_required/password_request/hidden_inputs'

module PasswordRequired
  class PasswordRequest
    include ActiveModel::Model

    IGNORED_PARAMETER_KEYS = [:action, :controller]

    delegate :env, :parameters, to: :@request

    attr_accessor :password

    def initialize(request)
      @request = request
      super({})
    end

    def target_url
      env['ORIGINAL_FULLPATH']
    end

    def additional_params
      parameters.except(*IGNORED_PARAMETER_KEYS)
    end

    def hidden_form_inputs
      HiddenInputs.new(additional_params).to_s
    end
  end
end
