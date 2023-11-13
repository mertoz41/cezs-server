class VideoConverter
    def initialize(post_id, user_id)
      @post = Post.find(post_id)
      @user = User.find(user_id)
    end
  
    def convert!
      process_video
    end
  
    private
  
    def process_video
      @post.clip.open(tmpdir: "/tmp") do |file|
        movie = FFMPEG::Movie.new(file.path)
        path = "tmp/video-#{SecureRandom.alphanumeric(12)}.mp4"
        movie.transcode(
          path, 
          { video_codec: 'libx264', audio_codec: 'aac' }, 
          { |progress| ActionCable.server.broadcast "video_conversion_channel_#{@user.id}", progress}
        )
        @post.clip.attach(io: File.open(path), filename: "video-#{SecureRandom.alphanumeric(12)}.mp4", content_type: 'video/mp4')
      end
      ActionCable.server.broadcast "video_conversion_channel_#{@user.id}", PostSerializer.new(@post, :scope => @user)
    end
end