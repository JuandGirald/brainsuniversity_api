class ScheduleMailer < ApplicationMailer
  require 'sendgrid-ruby'
  include SendGrid

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def awaiting_tutor(schedule)
    personalization = Personalization.new
    personalization.to = Email.new(email: schedule.teacher.email )
    personalization.substitutions = Substitution.new(key: '-name-', value: schedule.teacher.first_name)
    personalization.substitutions = Substitution.new(key: '-modality-', value: schedule.modality)
    personalization.substitutions = Substitution.new(key: '-date-', value: schedule.start_at)
    
    mail = setup_mail('Tutoría Agendada', 'c9d81e0b-99cf-4849-af00-3110e2934e88', personalization)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    begin
      response = sg.client.mail._("send").post(request_body: mail.to_json)
    rescue Exception => e
      puts e.message
    end
  end

  def accepted_awaiting_payment(schedule)
    email_params(schedule)
    mail to: schedule.student.email, subject: "Tutoría aceptada"
  end

  def rejected(schedule)
    email_params(schedule)
    mail to: schedule.student.email, subject: "Tutoría rechazada"
  end

  def expired
    email_params(schedule)
    mail to: schedule.student.email, subject: "Tutoría vencida"
  end

  def confirmed(schedule)
  end

  def completed(schedule) 
  end

  def canceled(schedule)
  end
  
  private
    def email_params(schedule)
      @student = schedule.student
      @schedule = schedule
      @teacher = schedule.teacher
    end

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
