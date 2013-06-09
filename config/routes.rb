Teams::Application.routes.draw do

  root :to => 'root#index'

  # for OmniAuth
  match "/auth/:provider/callback" => "sessions#callback"
  match "/logout" => "sessions#destroy", :as => :logout
end
