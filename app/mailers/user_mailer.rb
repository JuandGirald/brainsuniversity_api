class UserMailer < ApplicationMailer
  require 'sendgrid-ruby'
  include SendGrid

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    mail = Mail.new
    mail.from = Email.new(email: 'info@brainsuniversity.com')
    mail.subject = 'Bienvenido a BrainsTutor'
    personalization = Personalization.new
    personalization.to = Email.new(email: user.email )
    personalization.substitutions = Substitution.new(key: '-token-', value: user.activation_token)
    personalization.substitutions = Substitution.new(key: '-name-', value: user.first_name)
    personalization.substitutions = Substitution.new(key: '-email-', value: user.email)
    personalization.substitutions = Substitution.new(key: '-clientUrl-', value: ENV['API_URL'])
    mail.personalizations = personalization
    mail.contents = Content.new(type: 'text/html', value: 'I\'m replacing the <strong>body tag</strong>')
    mail.template_id = 'a4b12487-715e-47ee-ba0b-d1873ca5ba76'

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    begin
      response = sg.client.mail._("send").post(request_body: mail.to_json)
    rescue Exception => e
      puts e.message
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def schedule_step(user)
    @user = user
    mail to: user.email, subject: "Schedule an Appointment"
  end
end
