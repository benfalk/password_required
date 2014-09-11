Rails.application.routes.draw do
  root 'pages#index'
  mount PasswordRequired::Engine => "/password_required"
end
