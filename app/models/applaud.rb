class Applaud < ApplicationRecord
    belongs_to :applauding_user, class_name: "User", foreign_key: 'user_id'
    belongs_to :post
    has_many :notifications, dependent: :destroy

    def send_notifications(user_id)
        
        if self.post.user
            parsed = JSON.parse({applaud_id: self.id, user_id: self.post.user.id, action_user_id: user_id}.to_json)
            CreateNotificationJob.perform_async(parsed)
        else
            self.post.band.members.each do |member|
                CreateNotificationJob.perform_async({applaud_id: self.id, user_id: member.id, action_user_id: user_id})
            end
        end
    end
end
