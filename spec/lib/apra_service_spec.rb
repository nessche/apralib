# encoding: utf-8
require 'apralib'

module ApraService

  describe 'Client' do

    describe 'initialize' do

      it 'should create a valid object' do

        service = Client.new('user','password')
        service.should_not be_nil

      end

      it 'should send the notification to the server' do

        service = Client.new('***REMOVED***', '***REMOVED***')
        notification = Notification.new
        grantee = Grantee.new
        grantee.first_names='Teppo'
        grantee.last_name = 'Taiteilija'
        grantee.ssn = '230637-891Y'
        notification.grantee = grantee
        notification.granted_to_group = false
        notification.expense_amount = 0
        notification.amount = 10000
        notification.purpose = 'Patsaan rakentaminen'
        notification.grant_date = Date.today << 1
        notification.reference = 'Tama on testi-ilmoitus'
        notification.work_months = 1
        notification.work_days = 2
        notification.work_years = 3
        notification.work_start_date = Date.today
        notification.work_end_date = Date.today >> 1
        notification.reference = "Meidän viite"
        service.send_notifications(notification)

      end




    end



  end




end