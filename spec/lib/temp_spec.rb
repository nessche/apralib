require 'savon'

module ApraLib

  describe 'Just a test to see if it works' do


    it 'should work' do

      client = Savon.client(:wsdl => 'https://palvelu.mela.fi/Apurahailmoitukset/ws/apurahanSyottoWS?wsdl')

      puts client.operations

      puts client.operation :lisaa_apurahat



    end





  end



end