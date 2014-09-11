Rails.application.routes.draw do

  mount PasswordRequired::Engine => "/password_required"
end
