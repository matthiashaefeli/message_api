Rails.application.routes.draw do
  post '/new_message', to: 'messages#create'
  post '/update_message', to: 'messages#update'
  get '/messages', to: 'messages#index'
end
