# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def sign_up_confirmation
        UserMailer.sign_up_confirmation(User.first)
    end
end
