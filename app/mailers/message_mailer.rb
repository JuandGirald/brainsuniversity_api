class MessageMailer < ApplicationMailer
  require 'sendgrid-ruby'
  include SendGrid

  def inbox(message, recipient)
    @sender = message.user
    @recipient = recipient
    @message = message
    mail to: recipient.email, subject: "Nuevo Mensaje BrainsTutor"
  end
end