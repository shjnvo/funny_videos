class VideoForm
  include ActiveModel::Model
  attr_accessor :url

  validates :url, format: { with: /(https?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.*(?:watch\?v=)?([-\w]{11})/, message: 'youtube video format invalid!!!!' }

  def initialize(url = nil)
    @youtube_service = YoutubeService.new
    @url = url
    @errors = nil
  end

  def submit_by(user)
    return false unless valid?
    video_id = @youtube_service.take_video_id_by_url(@url)
    video_info = @youtube_service.take_info_video_by_ids(video_id)

    Rails.logger.info(video_info)

    if video_info.key?(:error)
      @errors = video_info[:error]
    else
      video_info[:records].each do |video|
        Video.create!({
          user_id: user.id,
          uuid: video_id,
          video_url: @url
        })
      end
    end

    @errors.nil?
  end

  def errors
    @erros
  end
end
