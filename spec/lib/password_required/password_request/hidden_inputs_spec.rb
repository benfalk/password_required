require 'rails_helper'

module PasswordRequired
  class PasswordRequest
    describe HiddenInputs do
      let(:inputs) do
        {
          top: 'name',
          second: {
            level: 'thing',
            array: %w(one two three),
            nesting: {
              name: 'ben'
            }
          }
        }
      end
      subject { HiddenInputs.new(inputs).to_s }

      it { should match(/name="top"/) }
      it { should match(/name="second\[level\]/) }
      it { should match(/name="second\[array\]\[\]/) }
      it { should match(/name="second\[nesting\]\[name\]/) }
    end
  end
end
