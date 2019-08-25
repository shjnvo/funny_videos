class LikeForm
  attr_accessor :uuid, :status

  def initialize(uuid, user, status)
    @youtube_service = YoutubeService.new
    @uuid = uuid
    @status = status
    @user = user
    @error = nil
  end

  def submit
    video = Video.find_by(uuid: uuid)
    if video && status_valid?(@status)
      likeable = Likeable.find_or_initialize_by(
                            video_id: video.id,
                            user_id: @user&.id,
                          )
      likeable.status = @status

      if likeable.save
        @youtube_service.video_action_by(@uuid, @status)
      else
        @error = likeable.error.full_messages.join(', ')
      end
    elsif !status_valid?(@status)
      @error = "Video action invalid !!!"
    else
      @error = "Video of uuid invalid!!!"
    end

    @error.nil?
  end

  def error
    @error
  end

  private

  def status_valid?(status)
    Likeable.statuses.include?(status)
  end
end
