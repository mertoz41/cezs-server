class ApplaudsController < ApplicationController
    def applaudpost
        applaud = Applaud.create(post_id: params[:post_id], user_id: logged_in_user.id)
        if applaud.post.user
            @new_notification = ApplaudNotification.create(applaud_id: applaud.id, user_id: applaud.post.user.id, action_user_id: logged_in_user.id, seen: false)
            if applaud.post.user.notification_token
                SendNotificationJob.perform_later(
                    applaud.post.user.notification_token.token,
                    "#{@new_notification.applauding_user.username} applauded your post.",
                    ApplaudNotificationSerializer.new(@new_notification).as_json

                )
            end
        else
            applaud.post.band.members.each do |member|
                @new_notification = ApplaudNotification.create(applaud_id: applaud.id, user_id: member.id, action_user_id: logged_in_user.id, seen: false)
                if member.notification_token
                    SendNotificationJob.perform_later(
                        member.notification_token.token,
                        "#{@new_notification.applauding_user.username} applauded #{applaud.post.band.name}#{applaud.post.band.name.last == 's' ? "'" : "'s"} post!",
                        ApplaudNotificationSerializer.new(@new_notification).as_json
                    )
                end
            end
            # post is a band post, check all members of band

        end

        render json: {message: 'post applauded.'}
    end

    def unapplaudpost
        applaud = Applaud.find_by(user_id: logged_in_user.id, post_id: params[:id])
        applaud.destroy
        render json: {message: 'post unapplauded.'}
    end
end
