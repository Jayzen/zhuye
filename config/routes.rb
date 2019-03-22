Rails.application.routes.draw do
  constraints(SubdomainRoutes) do 
    root "welcomes#index"
  end 

  constraints(!SubdomainRoutes) do
    root 'welcomes#show'
    get 'echo', to: "welcomes#feedback", as: :echo
    get 'present', to: "welcomes#introduction", as: :present
    get 'release', to: "welcomes#article", as: :release
    get 'release/:id', to: "welcomes#press", as: :press
    get 'product', to: "welcomes#service", as: :product
    get 'serve/:id', to: "welcomes#serve", as: :serve
    get 'apply', to: "welcomes#recruit", as: :apply
    get 'invite/:id', to: "welcomes#invite", as: :invite
    get 'plat', to: "welcomes#map", as: :plat
    get 'picture', to: "welcomes#photograph", as: :picture
    get 'staff', to: "welcomes#employee", as: :staff
  end

  resources :admins do
    get 'delete', on: :member
    get 'privileges', on: :member
    put 'update_privilege', on: :member
    get 'search', on: :collection
  end

  devise_for :users, path: "", path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  resources :employees do
    get 'delete', on: :member
    get 'set_weight', on: :member
    get 'set_reveal', on: :member
  end

  resources :carousels do
    get 'delete', on: :member
    get 'set_weight', on: :member
    get 'set_reveal', on: :member
    get 'attributes_reveal', on: :member
  end

  resources :contacts, :introductions, :articles, :services, :recruits do
    get 'delete', on: :member
    get 'set_weight', on: :member
    get 'set_reveal', on: :member
  end 

  resources :feedbacks do
    get 'delete', on: :member
  end
  
  resources :navbars do 
    get 'background', on: :collection
    put 'set_background', on: :collection
    get 'color', on: :collection
    put 'set_color', on: :collection
    get 'position', on: :collection
    put 'set_position', on: :collection
    get 'modify', on: :collection
    put 'set_modify', on: :collection
    get 'order', on: :collection
    put 'sort', on: :collection
  end

  resources :basics do
    get 'background', on: :collection
    put 'set_background', on: :collection
    get 'contact', on: :collection
    put 'set_contact', on: :collection
    get 'map_position', on: :collection
    put 'set_map_position', on: :collection
    get 'map_height', on: :collection
    put 'set_map_height', on: :collection
    put 'set_small_map', on: :collection
  end
  
  resources :options do 
    get 'set_reveal', on: :member
  end


  resources :maps do
    get 'delete', on: :member
    get 'set_weight', on: :member
  end

  resources :photographs do
    get 'delete', on: :member
    get 'set_weight', on: :member
    get 'set_reveal', on: :member
  end
    
  resources :pictures, only: [:create]
  get 'kind/:id', to: "welcomes#kind", as: :kind
  resources :logos do
    get 'reveal', on: :member
  end
end
