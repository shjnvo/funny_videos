class VideoForm
  include ActiveModel::Model
  attr_accessor :url

  validates :url, format: { with: /(https?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.*(?:watch\?v=)?([-\w]{11})/, message: 'url format invalid!!!!' }

  def initialize(url = nil)
    @youtube_service = YoutubeService.new
    @url = url
    @error = nil
  end

  def submit
    video_id = @youtube_service.take_video_id_by_url(@url)
    video_info = @youtube_service.take_info_video_by_ids(video_id)
    if video_info.key?(:error)
      @error = video_info[:error]
    else
      video_info[:records].each do |video|
        a = {
              id: video['id'],
              title: video['snippet']['title'],
              description: video['snippet']['description']
            }
        p a
      end
    end
    p video_id
    @error.nil?
  end
end
