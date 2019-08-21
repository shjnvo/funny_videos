class YoutubeService
  include HTTParty
  base_uri 'https://www.googleapis.com'

  def initialize
    @option = {
      query: {
        fields: "items(id,snippet(title,description),statistics)",
        part: "snippet,statistics",
        key: "AIzaSyBd7lNjNqVUpzTRCabe0-DZRkt4OmxxYN8"
      }
    }
  end

  def call(*video_id)
    @option[:query][:id] = video_id.join(',')
    response = self.class.get("/youtube/v3/videos", @option)

    JSON.parse(response.body)
  end
end
