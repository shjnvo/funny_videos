class YoutubeService
  include HTTParty
  base_uri 'https://www.googleapis.com'
  YOUTUBE_REGEX = /(https?:\/\/)?((w){3}.)?youtu(be|.be)?(\.com)?\/.*(?:watch\?v=)?([-\w]{11})/
  def initialize
    @option = {
      query: {
        fields: "items(id,snippet(title,description),statistics)",
        part: "snippet,statistics",
        key: "AIzaSyBd7lNjNqVUpzTRCabe0-DZRkt4OmxxYN8"
      }
    }
  end

  def take_info_video_by_ids(*video_id)
    @option[:query][:id] = video_id.join(',')
    response = self.class.get("/youtube/v3/videos", @option)
    if response.code
      records = JSON.parse(response.body)['items']
      { records: records }
    else
      error = JSON.parse(response.body)['error']
      { error: error }
    end
  end
  def take_video_id_by_url(url)
    url.match(YOUTUBE_REGEX)[6]
  end
end