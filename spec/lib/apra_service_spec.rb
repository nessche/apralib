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
        expect(service).not_to be_nil

      end

    end

    describe 'send_notifications' do

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
        notification.reference = SecureRandom.hex(16)
        notification.work_duration_months = 1
        notification.work_duration_days = 2
        notification.work_duration_years = 3
        notification.ignore_work_duration = true
        notification.work_start_date = Date.today
        notification.work_end_date = Date.today >> 1
        notification1 = Notification.new
        notification1.grantee = grantee
        notification1.granted_to_group = false
        notification1.expense_amount = 0
        notification1.amount = 10000
        notification1.purpose = 'Patsaan rakentaminen'
        notification1.grant_date = Date.today << 1
        notification1.reference = SecureRandom.hex(10)
        notification1.work_duration_months = 1
        notification1.work_duration_days = 2
        notification1.work_duration_years = 3
        notification1.ignore_work_duration = true
        notification1.work_start_date = Date.today
        notification1.work_end_date = Date.today >> 1
        response = service.send_notifications([notification, notification1])
        expect(response).not_to be_nil
        failed_notifications = response.failed_notifications
        expect(failed_notifications).not_to be_nil
        expect(failed_notifications).to be_a Array
        expect(failed_notifications.count).to eq(1)
        notification_response = failed_notifications[0]
        expect(notification_response.error).not_to be_nil
        expect(notification_response.notification.reference).to eq(notification.reference)
      end

      it 'should return an empty response when an empty array is passed' do
        service = get_client
        response = service.send_notifications([])
        expect(response).not_to be_nil
        expect(response.failed_notifications.count).to eq(0)
      end


    end



  end




end