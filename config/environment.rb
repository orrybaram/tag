# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Tag::Application.initialize!

# email
Tag::Application.configure do
  config.action_mailer.delivery_method =:sendmail

  config.action_mailer.sendmail_settings = {
    :address	=> "stmp.gmail.com",
    :port	=> "587",
    :domain     => "tag.com",
    :authentication => "plain",
    :user_name	=> "yueying",
    :password	=> "yueying",
    :enable_starttls_auto => true
  }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
end
