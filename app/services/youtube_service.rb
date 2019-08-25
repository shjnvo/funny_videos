class YoutubeService
  include HTTParty
  base_uri 'https://www.googleapis.com'

  YOUTUBE_REGEX = /(https?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.*(?:watch\?v=)?([-\w]{11})/

  def initialize
    @option = {
      query: {
        key: "AIzaSyBd7lNjNqVUpzTRCabe0-DZRkt4OmxxYN8"
      },
      headers: {}
    }
  end

  def take_info_video_by_ids(*video_id)
    @option[:query][:id] = video_id.join(',')
    @option[:query][:fields] = "items(id,snippet(title,description),statistics)"
    @option[:query][:part] = "snippet,statistics"
    response = self.class.get("/youtube/v3/videos", @option)

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

  def video_action_by(video_id, action)
    @option[:query][:id] = video_id
    @option[:query][:rating] = action
    @option[:headers]['Authorization'] = "Bearer ya29.GltvB33LKZ3DMVV5NvlzMXXC44_WYOC502mQKkgmmR96rHAfP0pqQtTKdumiIVVHhEGQ3c5mKCMGXlCkRHq21BVqwTgp4IuywaXyQOp8tTP0m_HVsHrRSoNOdRyC"
    response = self.class.post("/youtube/v3/videos/rate", @option)
  end
end
