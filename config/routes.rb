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
  end

  get 'select', to: "selects#select", as: :select
  get 'advertise', to: "selects#advertise", as: :advertise
  get 'official', to: "selects#official", as: :official
  get 'dimension', to: "selects#dimension", as: :dimension

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

  resources :contacts, :introductions, :articles, :services, :recruits, :tags, :categories do
    get 'delete', on: :member
    get 'set_weight', on: :member
    get 'set_reveal', on: :member
  end 

  resources :devices do 
    get 'rqrcode', on: :member
    get 'delete', on: :member
    get 'public_show', on: :member
    resources :device_attaches do
      get 'delete', on: :member
      get 'delete_all', on: :collection
    end
  end

  resources :feedbacks do
    get 'delete', on: :member
  end

  resources :options do 
    get 'set_reveal', on: :member
    get 'order', on: :collection
    put 'sort', on: :collection
    get 'navbar', on: :collection
    put 'set_navbar', on: :collection
    get 'map', on: :collection
    put 'set_map', on: :collection
    get 'style', on: :collection
    put 'set_style', on: :collection
    get 'modify', on: :collection
    put 'set_modify', on: :collection
  end

  resources :set_advertises do
    get 'contact', on: :collection
    put 'set_contact', on: :collection
    get 'map_height', on: :collection
    put 'set_map_height', on: :collection
  end

  resources :set_dimensions do
    get 'logo', on: :collection
    put 'set_logo', on: :collection
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
    
  resources :basics
  resources :pictures, only: [:create]
  get 'kind/:id', to: "welcomes#kind", as: :kind
  resources :logos
end
