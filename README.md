# Apralib


[!(https://travis-ci.org/nessche/apralib.svg?branch=master)
[![Gem Version](https://badge.fury.io/rb/apralib.svg)](http://badge.fury.io/rb/apralib)


A Ruby library to submit documents to the Apra Service run by [Maatalousyrittäjien eläkelaitos](http://www.mela.fi)

## Installation

Add this line to your application's Gemfile:

    gem 'apralib'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apralib

## Usage

To use this gem you will need credentials from [Maatalousyrittäjien eläkelaitos](http://www.mela.fi).

Once you have obtained the credentials you can instantiate a client

    ApraService::Client.new(username, password)

you can then create one or more notifications to be sent to the server

    notification = Notification.new
    grantee = Grantee.new
    grantee.first_names='Teppo'
    grantee.last_name = 'Taiteilija'
    grantee.ssn = '111111-111C'
    notification.grantee = grantee
    notification.granted_to_group = false
    notification.expense_amount = 0
    notification.amount = 10000
    notification.purpose = 'My grant purpose'
    notification.grant_date = Date.today << 1
    notification.reference = 'My project rede'
    notification.work_duration_months = 1
    notification.work_duration_days = 2
    notification.work_duration_years = 3
    notification.work_start_date = Date.today
    notification.work_end_date = Date.today >> 1
    service.send_notifications(notification)

As the information passed through the notification is dependent on the statutory earnings-related pension of those receiving
a grant or a scholarship from Finland, this readme does not explain the meaning of the different fields in the notification
object. For further information please refer to the [Mela website](http://www.mela.fi)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
