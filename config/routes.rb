Rails.application.routes.draw do
  devise_for :users
  
  get 'page/landing'
  root 'page#landing'
end
