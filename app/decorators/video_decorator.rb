class VideoDecorator < Draper::Decorator
  delegate_all

  delegate :current_page, :total_pages, :limit_value

  def initialize(object, options = {})
    super
    @video_service = YoutubeService.new
    @video_info = @video_service.take_info_video_by_ids(object.uuid).first
  end

  def self.collection_decorator_class
    PaginatingDecorator
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
