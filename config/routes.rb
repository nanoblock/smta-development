Rails.application.routes.draw do
  get 'page/landing'
  root 'page#landing'
end
