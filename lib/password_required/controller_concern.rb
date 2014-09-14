require 'password_required/password_request'

module PasswordRequired
  module ControllerConcern
    extend ActiveSupport::Concern

    class PasswordMissing < Exception; end
    class PasswordWrong < Exception; end
    class UserCanceled < Exception; end

    included do
      def self.password_required(opts = {})
        actions = Array(opts.fetch(:for) { fail ArgumentError })
        before_action :guard_with_password!, only: actions
      end

      rescue_from PasswordMissing, PasswordWrong, with: :present_password_request

      cattr_accessor :password_check_methods, instance_writer: false do
        ActiveSupport::HashWithIndifferentAccess.new(->(_) { false })
      end

      cattr_accessor :password_guard_conditions, instance_writer: false do
        ActiveSupport::HashWithIndifferentAccess.new(->() { true })
      end
    end

    def password_supplied?
      params[:password].present?
    end

    def password_correct?
      instance_exec(params[:password], &password_check_method)
    end

    def password_required?
      instance_exec(&password_guard_condition)
    end

    def password_guard_condition
      password_guard_conditions[action_name]
    end

    def password_check_method
      password_check_methods[action_name]
    end

    def guard_with_password!
      return unless password_required?
      fail PasswordMissing unless password_supplied?
      fail PasswordWrong unless password_correct?
    end

    def present_password_request
      @password_request ||= PasswordRequest.new(request)
      render 'password_request/new'
    end
  end
end
