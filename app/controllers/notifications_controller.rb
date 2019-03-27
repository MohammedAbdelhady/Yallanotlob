class NotificationsController < ApplicationController

    def get_new
    
    #    new_not = Notification.where('notifications.recipient_id =? and notifications.read is NULL',params[:id])
       not2 = Notification.select('users.name as sender,notifications.*').where('notifications.recipient_id =? and notifications.read is NULL',params[:id])
                .joins(:actor).where('actor_id = notifications.actor_id ').order('notifications.created_at DESC') || array();

        render json: {notifications: not2}
    end

    def get_all

        not2 = Notification.select('users.name as sender,notifications.*').where('notifications.recipient_id =?',params[:id])
        .joins(:actor).where('actor_id = notifications.actor_id ').order('notifications.created_at DESC')

        render json: {notifications: not2}
    end

    def mark_as_read

        read_not = Notification.where('notifications.recipient_id =? and notifications.read is NULL',params[:id])
        read_not.each do |notification|
            notification.update_attributes(:read => true)
        end
        render json: {notifications: read_not}
    end
    



    private 
    def set_user
        @user = User.find(params[:id])
    end
end
