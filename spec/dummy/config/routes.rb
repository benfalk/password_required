Rails.application.routes.draw do
  resources :widgets

  root 'pages#index'
  mount PasswordRequired::Engine => '/password_required'
end
