class VideosController < ApplicationController
  before_action :authenticate_user, only: :share
  def index
  end

  def share
  end

  def websocket
    render json: {}
  end
end
