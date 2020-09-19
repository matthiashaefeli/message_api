Rails.application.routes.draw do
  post '/message', to: 'messages#create'
  post '/update_message', to: 'messages#update'
  get '/message', to: 'messages#index'
  get '/provider', to: 'providers#index'
  post '/provider', to: 'providers#create'
  post '/update_provider', to: 'providers#update'
end
