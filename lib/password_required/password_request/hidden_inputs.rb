module PasswordRequired
  class PasswordRequest
    class HiddenInputs
      include ActionView::Helpers::FormTagHelper

      attr_reader :namespaces

      def initialize(params, namespaces: [])
        @params = params
        @namespaces = namespaces
      end

      def to_s
        @params.reduce('') do |input_html, key_value_pair|
          input_html + input_from(*key_value_pair)
        end
      end

      private

      def input_from(key, value)
        if value.is_a? Hash
          self.class.new(value, namespaces: namespaces | [key]).to_s
        else
          devise_input namespaced(key), value
        end
      end

      def devise_input(key, value)
        key += '[]' if value.is_a? Array
        Array(value).map { |i| hidden_field_tag key, i }.join('')
      end

      def namespaced(key)
        first, *rest = *(namespaces | [key])
        "#{first}#{rest.reduce('') { |a, e| a + "[#{e}]" }}"
      end
    end
  end
end
