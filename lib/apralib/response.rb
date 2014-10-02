module ApraService

  class Response

    attr_accessor :failed_notifications


    def self.from_hash(hash)
      puts hash.inspect
      response = Response.new
      raw_response = hash[:lisaa_apurahat_response]
      failures = raw_response[:epaonnistuneet_ilmoitukset]
      if failures
        failures = [failures] unless failures.is_a? Array
        response.failed_notifications = failures.map {|notification| NotificationResponse.from_hash(notification) }
      else
        response.failed_notifications = []
      end
      response
    end


  end




end