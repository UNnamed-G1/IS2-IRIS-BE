# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview
    def invitation_event_mail
        EventMailer.invitation_event_mail(User.first, Event.first)
    end
end
