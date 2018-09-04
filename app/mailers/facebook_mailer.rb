class FacebookMailer < ActionMailer::Base
  default from: 'info@hollowearthradio.org'

  def failure_email(e)
    @message = e.message
    @backtrace = e.backtrace
    mail(to: ENV['FACEBOOK_FAILURE_EMAIL'], subject: 'Facebook Event Failure')
  end
end
