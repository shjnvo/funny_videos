Rails.application.routes.draw do
  post 'sessions/create'
  delete 'sessions/destroy'
  post 'users/create'
  root 'videos#index'
  get '/websocket', to: 'videos#websocket'
  get '/share', to: 'videos#share'
  post '/share', to: 'videos#share'
  post '/video_action', to: 'videos#video_action'
end
