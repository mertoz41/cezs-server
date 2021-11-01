class PlaylistNotification < ApplicationRecord
    belongs_to :playlist
    belongs_to :playlist_user, class_name: 'User', foreign_key: :action_user_id
    belongs_to :user
end
