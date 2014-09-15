require 'rails_helper'

module PasswordRequired
  RSpec.describe PasswordRequest do
    let(:request) do
      double :request, env: env,
                       parameters: parameters
    end

    let(:env)        { {} }
    let(:parameters) { {} }

    it 'is initialized with a request' do
      expect { PasswordRequest.new(request) }.to_not raise_error
    end

    context 'env REQUEST_METHOD of post' do
      let(:env) do
        {
          'REQUEST_METHOD' => 'POST',
          'ORIGINAL_FULLPATH' => '/roflcopters'
        }
      end
      subject { PasswordRequest.new(request) }

      its(:target_url) { should eq('/roflcopters') }
    end
  end
end
