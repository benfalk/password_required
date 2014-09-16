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
      let(:parameters) do
        {
          controller: '/foo',
          action: 'old',
          widget: { name: 'test' }
        }
      end
      subject { PasswordRequest.new(request) }

      its(:target_url) { should eq('/roflcopters') }
      its(:additional_params) { should eq(widget: { name: 'test' }) }
    end

    describe '#hidden_form_inputs' do
      subject { PasswordRequest.new(request) }
      it 'initializes with addtional params and calls "to_s" on it' do
        expect(subject).to receive(:additional_params).and_return({})
        expect(PasswordRequest::HiddenInputs).to receive(:new).with({}).and_return('roflcopter')
        expect(subject.hidden_form_inputs).to eq('roflcopter')
      end
    end
  end
end
