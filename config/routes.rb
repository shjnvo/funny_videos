Rails.application.routes.draw do
  post 'sessions/create'
  delete 'sessions/destroy'
  post 'users/create'
  root 'videos#index'
  get '/websocket', to: 'videos#websocket'
  get '/share', to: 'videos#share'
end
