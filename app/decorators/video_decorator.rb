class VideoDecorator < Draper::Decorator
  delegate_all

  def initialize(object, options = {})
    super
    @youtube_service = YoutubeService.new
    video_info = @youtube_service.take_info_video_by_ids(object.uuid)[:records].first
    @title = video_info['snippet']['title']
    @description = video_info['snippet']['description']
    @like_number = video_info['statistics']['likeCount']
    @dislike_number = video_info['statistics']['dislikeCount']
  end

  def email
    user.email
  end

  def title
    @title
  end

  def description
    @description
  end

  def like_number
    @like_number
  end

  def dislike_number
    @dislike_number
  end
end
