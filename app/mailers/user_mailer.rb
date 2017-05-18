class UserMailer < ApplicationMailer
  require 'sendgrid-ruby'
  include SendGrid

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    personalization = Personalization.new
    personalization.to = Email.new(email: user.email )
    personalization.substitutions = Substitution.new(key: '-token-', value: user.activation_token)
    personalization.substitutions = Substitution.new(key: '-name-', value: user.first_name)
    personalization.substitutions = Substitution.new(key: '-email-', value: user.email)
    personalization.substitutions = Substitution.new(key: '-clientUrl-', value: ENV['API_URL'])
    
    mail = setup_mail('Bienvenido a BrainsTutor', 'a4b12487-715e-47ee-ba0b-d1873ca5ba76', personalization)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    begin
      response = sg.client.mail._("send").post(request_body: mail.to_json)
    rescue Exception => e
      puts e.message
    end
  end

  def accepted_tutor(user)
    personalization = Personalization.new
    personalization.to = Email.new(email: user.email )
    personalization.substitutions = Substitution.new(key: '-name-', value: user.first_name)
    personalization.substitutions = Substitution.new(key: '-email-', value: user.email)
    
    mail = setup_mail('Tutor Aceptado', '33909bc2-2c54-4660-8859-40c5fd1ecca8', personalization)
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

  private
    def setup_mail(subject, template_id, personalization)
      mail = Mail.new
      mail.from = Email.new(email: 'info@brainsuniversity.com')
      mail.subject = subject
      mail.contents = Content.new(type: 'text/html', value: 'I\'m replacing the <strong>body tag</strong>')
      mail.personalizations = personalization
      mail.template_id = template_id
      mail
    end
end
