# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def sign_up_confirmation
        UserMailer.sign_up_confirmation(User.first)
    end

    def receive_comments_mail
        UserMailer.receive_comments_mail("Dejar un comentario", User.first, "asdadasdasdasd")
    end

    def new_follower_mail
        UserMailer.new_follower_mail(User.last, User.find(101))
    end
end
