class VideosController < ApplicationController
  before_action :authenticate_user, only: :share
  def index
    @videos = Video.includes(:user).all.decorate
  end

  def share
    @video_form = VideoForm.new(params[:url])


    if request.method == "POST"
      if @video_form.submit_by(current_user)
        redirect_to root_path, notice: "Share video success !!!"
      else
        render :share
      end
    end
  end

  def video_action
    like_form = LikeForm.new(params[:uuid], current_user, params[:status])

    if like_form.submit
      redirect_to root_path, notice: "Video #{params[:status]} success!!!"
    else
      redirect_to root_path, alert: like_form.errors
    end
  end

  def websocket
    render json: {}
  end
end
