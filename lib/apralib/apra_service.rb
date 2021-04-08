# frozen_string_literal: true

require_relative 'notification'
require_relative 'response'
require 'savon'

module ApraService
  # The main entry point for the library
  class Client
    def initialize(username, password, proxy = nil)
      wsdl_file = File.expand_path('../wsdl/ApurahanSyotto.wsdl', __dir__)

      @client = Savon.client(wsdl: wsdl_file,
                             wsse_auth: [username, password],
                             endpoint: 'https://palvelurajapinta.mela.fi/Apurahailmoitukset/ApurahanSyotto',
                             proxy: proxy,
                             follow_redirects: true)
    end

    def type_or_array_of_type(arg, type, message)
      raise ArgumentError, 'object cannot be nil' unless arg

      return if arg.is_a?(type) || (arg.is_a?(Array) && arg.all? { |i| i.is_a? type })

      raise ArgumentError, message
    end

    def send_notifications(notifications)

      type_or_array_of_type(notifications, Notification,
                            'notifications object must be either a Notification object' + 
                              'or an array of Notification objects')

      notifications = [notifications] unless notifications.is_a? Array
      if notifications.count.positive?
        message = { apurahailmoitustiedot: notifications.map(&:to_hash) }
        response = @client.call(:lisaa_apurahat, message: message)
        raise 'An error occurred while submitting the notification' unless response.success?

        Response.from_hash(response.body)
      else
        Response.new
      end
    end
  end
end
