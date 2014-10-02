require_relative 'notification'
require_relative 'response'
require 'savon'

module ApraService

  class Client

    def initialize(username, password)
      @client = Savon.client(wsdl: 'https://palvelu.mela.fi/Apurahailmoitukset/ws/apurahanSyottoWS?wsdl',
                             wsse_auth: [username, password],
                             endpoint: 'https://palvelu.mela.fi/Apurahailmoitukset/ws/apurahanSyottoWS')
    end

    def send_notifications(notifications)
      raise ArgumentError, 'notifications object cannot be nil' unless notifications
      raise ArgumentError, 'notifications object must be either a Notification object or an array of Notification objects' unless
          (notifications.is_a? Notification or (notifications.is_a? Array and notifications.detect {|n| !n.is_a? Notification}.nil?))
      notifications = [notifications] unless notifications.is_a? Array
      message = {}
      message[:arg0] = notifications.map {|notification| notification.to_hash}
      response = @client.call(:lisaa_apurahat, :message => message)
      raise RuntimeError, 'An error occurred while submitting the notification' unless response.success?
      Response.from_hash(response.body)
    end



  end


end