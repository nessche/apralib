# encoding: utf-8
require 'apralib'

module ApraService


  describe 'Client' do

    def get_client
      credentials = {}
      credentials_file = File.join(File.dirname(__FILE__), 'apra_credentials.yml')
      credentials = YAML.load(File.read(credentials_file)) if File.exists?(credentials_file)
      user = credentials['user'] || ENV['APRA_USER']
      password = credentials['password'] || ENV['APRA_PASSWORD']
      Client.new(user, password)
    end


    describe 'initialize' do

      it 'should create a valid object' do

        service = Client.new('user','password')
        service.should_not be_nil

      end

      it 'should send the notification to the server' do

        service = get_client
        notification = Notification.new
        grantee = Grantee.new
        grantee.first_names='Teppo'
        grantee.last_name = 'Taiteilija'
        grantee.ssn = '111111-111C'
        notification.grantee = grantee
        notification.granted_to_group = false
        notification.expense_amount = 0
        notification.amount = 10000
        notification.purpose = 'Patsaan rakentaminen'
        notification.grant_date = Date.today << 1
        notification.reference = 'Tama on testi-ilmoitus'
        notification.work_duration_months = 1
        notification.work_duration_days = 2
        notification.work_duration_years = 3
        notification.work_start_date = Date.today
        notification.work_end_date = Date.today >> 1
        service.send_notifications(notification)

      end




    end



  end




end