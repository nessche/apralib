module ApraService

  class NotificationResponse

    attr_accessor :notification, :error

    def initialize(notification, error)
      @notification = notification
      @error = error
    end


    def self.from_hash(hash)
      notification = Notification.from_hash(hash[:ilmoitus])
      error = hash[:virhe]
      NotificationResponse.new(notification, error)
    end


  end


end