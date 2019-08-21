Rails.application.routes.draw do
  root 'videos#index'
  get '/websocket', to: 'videos#websocket'
  get '/share', to: 'videos#share'
end
