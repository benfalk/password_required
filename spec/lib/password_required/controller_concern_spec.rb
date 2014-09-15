require 'rails_helper'

module PasswordRequired
  AnonymousController = Class.new(ApplicationController) do
    def nothing
      render nothing: true
    end

    def self.name
      'AnonymousController'
    end

    def controller_name
      'anonymous'
    end

    [:create, :update, :destroy, :show, :index, :edit, :new].each do |m|
      alias_method m, :nothing
    end
  end

  RSpec.describe ControllerConcern, type: :controller do

    subject { ControllerConcern }

    before do
      routes.draw do
        resources :things, controller: 'anonymous'
      end
    end

    it { should be_a(Module) }

    context 'when included in a controller' do
      controller(AnonymousController) do
        include ControllerConcern
      end

      context 'The controller class' do
        subject { controller.class }

        describe '#password_required()' do
          it 'will raise an error if for: key is not found' do
            expect { subject.password_required }.to raise_error(ArgumentError)
          end

          it 'will set a before_action of guard_with_password!' do
            expect(subject).to receive(:before_action).with(:guard_with_password!, only: [:new])
            subject.password_required for: :new
          end
        end
      end

      context 'The instance methods' do
        subject { controller }

        describe '#guard_with_password!' do
          it 'does not raise exceptions when #password_required? is false' do
            expect(subject).to receive(:password_required?).and_return(false)
            expect { subject.guard_with_password! }.to_not raise_error
          end

          it 'raises a PasswordMissing exception if #password_supplied? is false' do
            expect(subject).to receive(:password_required?).and_return(true)
            expect(subject).to receive(:password_supplied?).and_return(false)
            expect { subject.guard_with_password! }.to raise_error(ControllerConcern::PasswordMissing)
          end

          it 'raises PasswordWrong when password supplied but #password_correct? is false' do
            expect(subject).to receive(:password_required?).and_return(true)
            expect(subject).to receive(:password_supplied?).and_return(true)
            expect(subject).to receive(:password_correct?).and_return(false)
            expect { subject.guard_with_password! }.to raise_error(ControllerConcern::PasswordWrong)
          end
        end

        describe '#password_required?' do
          it 'delegates to password_guard_condition' do
            expect(subject).to receive(:password_guard_condition).and_return(-> { :roflcopter })
            expect(subject.password_required?).to eq(:roflcopter)
          end
        end

        describe '#password_supplied?' do
          it 'is true if the password param is not blank' do
            get :new, password_request: { password: 'roflcopter' }
            expect(subject.password_supplied?).to eq(true)
          end
        end

        describe '#password_correct?' do
          before do
            expect(subject).to receive(:password_check_method)
              .and_return(->(password) { password == 'roflcopterz' })
          end

          it 'delegates to password_check_method the password supplied' do
            post :create, password_request: { password: 'roflcopterz' }
            expect(subject.password_correct?).to eq(true)
          end

          it 'delegates to password_check_method' do
            post :create, password_request: { password: 'dink' }
            expect(subject.password_correct?).to eq(false)
          end
        end

        describe '#password_check_method' do
          let(:check_methods) do
            Hash.new(->(_) { false }).tap do |h|
              h['new'] = ->(password) { password == 'hawt' }
            end
          end
          before { allow(subject).to receive(:password_check_methods).and_return(check_methods) }

          it 'delegates to the password_check_methods with action_name' do
            get :new
            expect(subject.password_check_method).to be(check_methods['new'])
          end
        end

        describe 'password_guard_condition' do
          let(:condition_lambdas) do
            Hash.new(->() { false }).tap do |h|
              h['new'] = ->() { true }
            end
          end
          before { allow(subject).to receive(:password_guard_conditions).and_return(condition_lambdas) }

          it 'pulls from a hash "password_guard_conditions" using the action name' do
            get :new
            expect(subject.password_guard_condition).to be(condition_lambdas['new'])
          end

          it 'pulls from a hash "password_guard_conditions" using the action name' do
            get :index
            expect(subject.password_guard_condition).to_not be(condition_lambdas['new'])
          end
        end
      end # End of instance methods

      context 'Rescuing from exceptions' do
        subject { controller }

        [ControllerConcern::PasswordMissing, ControllerConcern::PasswordWrong].each do |exception|
          before do
            allow(subject).to receive(:new).and_raise(exception)
          end

          it "rescues from #{exception} by presenting a password form" do
            get(:new)
            expect(response).to render_template('password_request/new')
          end

          it 'assigns a PasswordRequest to be used' do
            expect(PasswordRequest).to receive(:new).with(request).and_return('hklol')
            get(:new)
            expect(assigns(:password_request)).to eq('hklol')
          end
        end
      end # End of rescuing from exceptions
    end
  end
end
