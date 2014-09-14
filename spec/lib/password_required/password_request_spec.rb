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
      let(:env) { { 'REQUEST_METHOD' => 'POST' } }

    end

  end
end
