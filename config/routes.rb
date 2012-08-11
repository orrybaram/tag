Tag::Application.routes.draw do
  get "welcome/1"
  get "welcome/2"
  get "welcome/3"
  get "welcome/4"
  get "welcome/5"
  get "welcome/6"
  get "welcome/7"
  get "welcome/8"
  get "welcome/9"
  get "welcome/10"
  get "welcome/11"
  get "welcome/12"
  get "welcome/studash"
  get "welcome/studash2"

  get "welcome/contact"

  resources :user_game_preferences

  # games
  resources :games

  resources :user_funs

  # funs
  match "/funs/home" => "funs#home" 
  match "/funs/fun_list" => "funs#fun_list" 
  match "/funs/my_fun_list" => "funs#my_fun_list" 
  resources :funs

  resources :music_likes

  # musics
  match "/musics/music_list" => "musics#music_list"
  resources :musics

  # sport_levels
  match "/sport_levels/sport_level_list" => "sport_levels#sport_level_list"
  match "/sport_levels/home" => "sport_levels#home"
  match "/sport_levels/guidence" => "sport_levels#guidence"
  match "/sport_levels/video" => "sport_levels#video"
  resources :sport_levels

  resources :scaffolds

  # admin
  get "/home" => "admin#home"
  get "/tools" => "admin#tools"

  # user_sport_preferences
  resources :user_sport_preferences

  resources :pe_classmembers

  # pe_classes
  match "/class" => "pe_classes#home"
  match "/class/news" => "pe_classes#news_list"
  resources :pe_classes

  resources :schools

  resources :teammembers

  # team
  match "/teams/home" => "teams#home"
  match "/teams/team_information" => "teams#team_information"
  match "/teams/teamowner_information" => "teams#teamowner_information"
  match "/teams/team_information_list" => "teams#team_information_list"
  match "/teams/score_list" => "teams#score_list"
  resources :teams

  # sports
  resources :sports

  # trainers
  match "/trainers/home" => "trainers#home"  
  resources :trainers 

  # teachers
  match "/teachers/home" => "teachers#home" 
  match "/teachers/class_list" => "teachers#class_list" 
  match "/teachers/student_list" => "teachers#student_list" 
  match "/teachers/student_information" => "teachers#student_information" 
  match "/teachers/event_list" => "teachers#event_list" 
  resources :teachers

  # events
  match "/events/datetime_list" => "events#datetime_list"
  match "/events/event_information" => "events#event_information"
  match "/events/my_event_information" => "events#my_event_information"
  resources :events

  # location
  match "/locations/location_list" => "locations#location_list"
  resources :locations

  get 'admin' => 'admin#index'

  # sessions
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy

    get 'login_teacher' => :new_teacher
    post 'login_teacher' => :create_teacher
    delete 'logout_teacher' => :destroy_teacher
  end

  get "sessions/new"

  get "sessions/create"

  get "sessions/destroy"

  resources :sessions

  # user
  match "/users/confirm_information" => "users#confirm_information"
  match "/users/confirm_parental_consent" => "users#confirm_parental_consent"
  match "/users/render_confirm_parental_consent" => "users#render_confirm_parental_consent"
  match "/users/render_reset_password" => "users#render_reset_password"
  match "/users/reset_password" => "users#reset_password"
  resources :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
