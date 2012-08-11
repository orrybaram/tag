class Notifier < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.parental_consent_confirmation.subject
  #
  def parental_consent_confirmation
    @greeting = "Hi from tag"

    mail(:to => "yueying.cui@gmail.com", :subject => "Welcome to TAG")
  end
end
