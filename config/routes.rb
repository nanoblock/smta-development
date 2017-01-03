Rails.application.routes.draw do
  devise_for :user, controllers: {  
  # confirmations: 'users/confirmations',
  passwords: 'users/passwords',
  registrations: 'users/registrations',
  sessions: 'users/sessions',
  # unlocks: 'users/unlocks',
  }, skip: [:sessions, :passwords]

  # devise_for :users

  as :user do 
    get 'login' => 'users/sessions#new', as: :new_user_session
    post 'login' => 'users/sessions#create', as: :user_session
    delete 'logout' => 'users/sessions#destroy', as: :destroy_user_session
    get 'sign_up' => 'users/registrations#new'
    get 'users/password/reset' => 'users/passwords#new', as: :new_user_password
    post 'users/password/reset' => 'users/passwords#create', as: :user_password
    get 'users/psasword/reset/edit' => 'users/passwords#edit', as: :edit_user_password
    put 'users/password/reset' => 'users/passwords#update'
    patch 'users/password/reset' => 'users/passwords#update'
    get 'users/password/reset/done' => 'users/passwords#done', as: :done_user_password
    # post 'validation' => 'users/sessions#login_validataion', as: :user_login_validataion
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
    post 'project/:project_name/relation' => 'project#relation', as: :image_relation_project
    post 'project' => 'project#create', as: :create_project
    post 'project/:project_name/preview' => 'project#preview', as: :preview_project
    post 'project/validate/:project_name' => 'project#project_validate', as: :validate_project_name
    get 'project/:project_name/preview' => 'project#preview'
    put 'project' => 'project#update', as: :project
    patch 'project' => 'project#update'
  end

  as :image do
    post 'project/:project_name/image/' => 'image#create', as: :create_project_image
    delete 'project/:project_name/image/:image_id' => 'image#destroy', as: :destroy_project_image
    post 'project/:project_name/image/destroy_all' => 'image#destroy_all', as: :destroy_all_project_image
    post 'project/image' => 'image#update', as: :create_image
    put 'project/:project_name/image/' => 'image#update', as: :image
    patch 'project/:project_name/image/' => 'image#update'
  end

  as :clickables do
    post 'project/:project_name/images/:image_id/clickables' => 'clickable#create', as: :project_image_clickables
    post 'project/:project_name/images/:image_id/clickables/destroy_all' => 'clickable#destroy_all', as: :destroy_all_project_image_clickables
  end

  get 'landing' => 'page#landing', as: :page_landing
  # get 'home' => 'page#home', as: :page_home
  get 'privacy' => 'page#privacy', as: :page_privacy
  get 'term' => 'page#term', as: :page_term
  get 'home' => 'page#search'
  post 'home' => 'page#search', as: :project_search
  
  get 'test' => 'page#test'

  root 'page#landing'
end
