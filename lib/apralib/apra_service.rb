require_relative 'notification'
require 'savon'

module ApraService

  class Client

    def initialize(username, password)
      @client = Savon.client(wsse_auth: [username, password])
    end

    def send_notifications(notifications)
      raise ArgumentError, 'notifications object cannot be nil' unless notifications
      raise ArgumentError, 'notifications object must be either a Notification object or an array of Notification objects' unless
          notifications.is_a? Notification or (notifications.is_a? Array and notifications.each {|n| !n.is_a? Notification}.nil?)
      notifications = [notifications] unless notifications.is_a? Array
      message = notifications.each_with_index.inject({}) do |hash, (notification, index)|
        hash["arg#{index}"] = notification.to_hash
      end
      response = @client.call(:lisaa_apurahat, :message => message)

    end



  end


end