require 'rails_helper'

module PasswordRequired
  module ControllerConcern
    describe ArgumentsComposer do
      let(:controller_class) do
        double :controller_class, password_check_methods: {},
                                  password_guard_conditions: {},
                                  before_action: nil
      end
      let(:options) { { for: :create } }
      subject { described_class }

      it 'should set password check methods using the :with key' do
        subject.new(options.merge(with: :something)).call(controller_class)
        expect(controller_class.password_check_methods[:create]).to be_a(Proc)
      end

      it 'should set password check methods with a proc' do
        subject.new(options.merge(with: ->() { true })).call(controller_class)
        expect(controller_class.password_check_methods[:create]).to be_a(Proc)
      end

      it 'should call before_action with :create' do
        subject.new(options).call(controller_class)
        expect(controller_class).to have_received(:before_action)
          .with(:guard_with_password!, only: [:create])
      end
    end
  end
end
