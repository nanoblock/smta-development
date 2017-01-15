Rails.application.routes.draw do
  devise_for :user, controllers: {  
  confirmations: 'users/confirmations',
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
    get 'profiles' => 'profile#show', as: :profile
    post 'profiles' => 'profile#create', as: :create_profile
    put 'profiles' => 'profile#update'
    patch 'profiles' => 'profile#update'
  end

  as :project do
    get 'projects' => 'project#new', as: :new_project
    get 'projects/:project_id' => 'project#show', as: :show_project
    post 'projects/:project_id' => 'project#show'
    post 'projects/:project_id/relation' => 'project#relation', as: :image_relation_project
    post 'projects/:project_id/videos/section' => 'project#section', as: :video_section_project
    # get 'project/:project_id/relation' => 'project#relation'
    post 'projects' => 'project#create', as: :create_project
    post 'projects/:project_id/preview' => 'project#preview', as: :preview_project
    post 'projects/validate/:project_id' => 'project#project_validate', as: :validate_project_id
    get 'projects/:project_id/preview' => 'project#preview'
    put 'projects' => 'project#update', as: :project
    patch 'projects' => 'project#update'
  end

  as :image do
    post 'projects/:project_id/images' => 'image#create', as: :create_project_image
    delete 'projects/:project_id/images/:image_id' => 'image#destroy', as: :destroy_project_image
    post 'projects/:project_id/images/destroy_all' => 'image#destroy_all', as: :destroy_all_project_image
    post 'projects/images/create' => 'image#create', as: :create_image
    put 'projects/:project_id/images' => 'image#update', as: :image
    patch 'projects/:project_id/images' => 'image#update'
  end

  as :clickables do
    post 'projects/:project_id/images/:image_id/clickables' => 'clickable#create', as: :project_image_clickables
    post 'projects/:project_id/images/:image_id/clickables/destroy_all' => 'clickable#destroy_all', as: :destroy_all_project_image_clickables
  end

  as :video do
    post 'api/videos/' => 'video#api_create', as: :api_create_project_video
  end

  as :video_clickables do
    post 'projects/:project_id/videos/:video_id/clickables' => 'video_clickable#create', as: :project_video_clickables
    post 'projects/:project_id/videos/:video_id/clickables/destroy_all' => 'video_clickable#destroy_all', as: :destroy_all_project_video_clickables
  end

  as :token do
    post 'tokens/validation' => 'application#validation', as: :token_validation
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
