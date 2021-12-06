class YoutubeService
  include HTTParty
  base_uri 'https://youtube.googleapis.com'

  YOUTUBE_REGEX = /(https?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.*(?:watch\?v=)?([-\w]{11})/

  def initialize
    @option = {
      query: {
        key: "AIzaSyAQ3DyijfPwAU1jbSPzUjai9dJ3MkO5i5w"
      },
      headers: {}
    }
  end

  def take_info_video_by_ids(*video_id)
    @option[:query][:id] = video_id.join(',')
    # @option[:query][:fields] = "items(id,snippet(title,description),statistics)"
    @option[:query][:part] = "snippet,contentDetails,statistics"
    response = self.class.get('/youtube/v3/videos', @option)

    Rails.logger.debug(response)

    if response.code == 200
      records = JSON.parse(response.body)['items']
      { records: records }
    else
      error = JSON.parse(response.body)['error']
      { error: error }
    end
  end

  def take_video_id_by_url(url)
    matched = url.match(YOUTUBE_REGEX)

    # in YOUTUBE_REGEX with group 6 is video_id
    video_id = matched ? matched[6] : nil
  end
end
