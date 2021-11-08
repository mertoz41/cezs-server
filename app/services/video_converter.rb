class VideoConverter
    def initialize(post_id)
      @post = Post.find(post_id)
    end
  
    def convert!
      process_video
    end
  
    private
  
    def process_video
      @post.clip.open(tmpdir: "/tmp") do |file|
        movie = FFMPEG::Movie.new(file.path)
        path = "tmp/video-#{SecureRandom.alphanumeric(12)}.mp4"
        movie.transcode(path, { video_codec: 'libx264', audio_codec: 'aac' }) { |progress| ActionCable.server.broadcast("video_conversion_#{@post.user_id}", progress)}
        @post.clip.attach(io: File.open(path), filename: "video-#{SecureRandom.alphanumeric(12)}.mp4", content_type: 'video/mp4')
      end
    end
  end