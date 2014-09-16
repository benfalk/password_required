module PasswordRequired
  module ControllerConcern
    class ArgumentsComposer
      VALID_KEYS = [:for, :with]

      def initialize(opts = {})
        @options = opts.slice(*VALID_KEYS)
        @options[:for] = Array(@options[:for])
      end

      def call(klass)
        @options.each_pair do |key, value|
          send("handle_#{key}_key", klass, value, @options[:for])
        end
      end

      private

      def handle_with_key(klass, value, actions)
        actions.each do |action|
          klass.password_check_methods[action] =
            if value.is_a? Proc
              value
            elsif value.is_a? Symbol
              ->(_) { send(value) }
            end
        end
      end

      def handle_for_key(klass, value, _)
        klass.send :before_action, :guard_with_password!, only: value
      end
    end
  end
end
