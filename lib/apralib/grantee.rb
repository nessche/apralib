module ApraService

  class Grantee

    SSN_REGEX = /(\d{6})([-+A])(\d{3})([0-9ABCDEFHJKLMNPRSTUVWXY])/
    CHECK_DIGITS = %w(0 1 2 3 4 5 6 7 8 9 A B C D E F H J K L M N P R S T U V W X Y)

    attr_accessor :first_names, :last_name, :ssn, :address, :zip

    def to_hash
      result = {}
      result[:apurahansaajanosoite] = address if address
      result[:apurahansaajanpostinumero] = zip if zip
      first_names.split(' ')[0..2].each_with_index do |name, index|
        result["etunimi#{index + 1}".to_sym] = name
      end
      result[:henkilotunnus] = ssn if ssn
      result[:sukunimi] = last_name

      result

    end

    def self.from_hash(hash)
      grantee = Grantee.new
      grantee.address = hash[:apurahansaajanosoite]
      grantee.zip = hash[:apurahansaajanpostinumero]
      grantee.first_names = [hash[:etunimi1]]
      grantee.first_names << hash[:etunimi2] if hash[:etunimi2]
      grantee.first_names << hash[:etunimi3] if hash[:etunimi3]
      grantee.ssn = hash[:henkilotunnus]
      grantee.last_name = hash[:sukunimi]
      grantee
    end

    def ssn=(ssn)
      if ssn
        Grantee.verify_ssn!(ssn.upcase)
        self.instance_variable_set('@ssn', ssn.upcase)
      else
        self.instance_variable_set('@ssn', nil)
      end
    end

    def self.verify_ssn!(ssn)
      raise RuntimeError, 'The Social Security Number is not in the correct format' unless ssn =~ SSN_REGEX
      big_number = "#{$1}#{$3}".to_i
      check = CHECK_DIGITS[big_number % 31]
      raise RuntimeError, "The check digit does not match, expected #{check}, got #{$4}" unless check == $4
    end

    def self.verify_ssn(ssn)
      begin
        verify_ssn! ssn
          true
      rescue RuntimeError => e
        puts e.message
        false
      end
    end




  end

end