Rails.application.routes.draw do
  devise_for :user, controllers: {  
  # confirmations: 'users/confirmations',
  passwords: 'users/passwords',
  registrations: 'users/registrations',
  sessions: 'users/sessions',
  # unlocks: 'users/unlocks',
  }, skip: [:sessions]

  # devise_for :users

  as :user do 
    get 'login' => 'users/sessions#new', as: :new_user_session
    post 'login' => 'users/sessions#create', as: :user_session
    delete 'logout' => 'users/sessions#destroy', as: :destroy_user_session
    get 'sign_up' => 'users/registrations#new'
  end

  as :profile do
    get 'profile' => 'profile#show', as: :profile
    post 'profile' => 'profile#create', as: :create_profile
    put 'profile' => 'profile#update'
    patch 'profile' => 'profile#update'
  end

  as :project do
    get 'project' => 'project#new', as: :new_project
    get 'project/:project_name' => 'project#show', as: :show_project
    post 'project' => 'project#create', as: :create_project
    put 'project' => 'project#update', as: :project
    patch 'project' => 'project#update'
  end

  as :image do
    post 'project/:project_name/image/' => 'image#create', as: :create_project_image
    delete 'project/:project_name/image/:image_id' => 'image#destroy', as: :destroy_project_image
    post 'project/:project_name/image/destroy_all' => 'image#destroy_all', as: :destroy_all_project_image
    put 'project/:project_name/image/' => 'image#update', as: :image
    patch 'project/:project_name/image/' => 'image#update'
  end

  get 'landing' => 'page#landing', as: :page_landing
  get 'home' => 'page#home', as: :page_home

  root 'page#landing'
end
