class VideoForm
  include ActiveModel::Model
  attr_accessor :url

  validates :url, format: { with: /(https?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.*(?:watch\?v=)?([-\w]{11})/, message: 'youtube video format invalid!!!!' }

  def initialize(url = nil)
    @video_service = VideoService.new
    @url = url
  end

  def submit_by(user)
    return false unless valid?

    video_id = @video_service.take_video_id_by_url(@url)
    opts = { id: video_id }
    videos = @video_service.list_videos(opts)

    Rails.logger.info(videos)

    if videos.present?
      videos.each do |video|
        Video.create!({
          user_id: user.id,
          uuid: video_id,
          video_url: @url
        })
      end
    else
      @error = "We area not match video with URL !!!"
    end

    @error.nil?
  end

end
