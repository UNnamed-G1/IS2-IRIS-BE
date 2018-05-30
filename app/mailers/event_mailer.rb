class EventMailer < ApplicationMailer

    def invitation_event_mail(recipient, event)
        @recipient = recipient
        @event = event
        path_images = "/app/assets/images/mailers"
        attachments.inline['iris_logo.png'] = File.read("#{Rails.root}#{path_images}/IRIS_logo.png")
        attachments.inline['unal_logo.png'] = File.read("#{Rails.root}#{path_images}/UNAL_escudo.png")
        
        full_name = @recipient.name + " " + @recipient.lastname
        email_with_name = %("#{full_name}" <#{@recipient.email}>)
        mail(to: email_with_name, subject: "Acabas de ser invitado a un evento.")
    end
end