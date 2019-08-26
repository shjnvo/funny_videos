class VideoService
  include AuthService

  YOUTUBE_REGEX = /(https?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.*(?:watch\?v=)?([-\w]{11})/
  YUOTUBE_PART = "snippet,statistics"

  def initialize
    @service = Google::Apis::YoutubeV3::YouTubeService.new
    @service.authorization = authorize
  end

  def take_video_id_by_url(url)
    matched = url.match(YOUTUBE_REGEX)

    # in YOUTUBE_REGEX with group 6 is video_id
    video_id = matched ? matched[6] : nil
  end

  def list_videos(part = YUOTUBE_PART, **opts)
    response = @service.list_videos(part, opts)

    response.items
  end

  def rate_video(video_id, rating = "none")
    response = @service.rate_video(video_id, rating)

    response
  end
end
