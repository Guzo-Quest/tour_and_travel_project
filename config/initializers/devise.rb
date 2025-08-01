Devise.setup do |config|
  config.mailer_sender = ENV['SMTP_EMAIL']
  config.mailer = 'Devise::Mailer'
  config.parent_mailer = 'ActionMailer::Base'
  config.authentication_keys = [:email]
  config.request_keys = []
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.params_authenticatable = true
  config.http_authenticatable = false

end
