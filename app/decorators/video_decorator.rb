class VideoDecorator < Draper::Decorator
  delegate_all

  def initialize(object, options = {})
    super
    @video_service = VideoService.new
    @video_info = @video_service.list_videos({id: object.uuid}).first
  end

  def email
    user.email
  end

  def title
    @video_info.snippet.title
  end

  def description
    @video_info.snippet.description
  end

  def like_number
    @video_info.statistics.like_count
  end

  def dislike_number
    @video_info.statistics.dislike_count
  end
end
