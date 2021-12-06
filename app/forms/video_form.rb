class VideoForm
  include ActiveModel::Model
  attr_accessor :url

  validates :url, format: { with: /(https?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.*(?:watch\?v=)?([-\w]{11})/, message: 'youtube video format invalid!!!!' }

  def initialize(url = nil)
    @video_service = YoutubeService.new
    @url = url
  end

  def submit_by(user)
    return false unless valid?

    video_id = @video_service.take_video_id_by_url(@url)


    if video_id.present?
      Video.create!({
        user_id: user.id,
        uuid: video_id,
        video_url: @url
      })
    else
      @error = "We area not match video with URL !!!"
    end

    @error.nil?
  end

end
