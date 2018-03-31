class UserMailer < ApplicationMailer

    def sign_up_confirmation(user)
        @user = user
        full_name = @user.name + " " + @user.lastname
        @url = 'localhost:4200/login'
        email_with_name = %("#{full_name}" <#{@user.email}>)
        mail(to: email_with_name, subject: "Bienvenido a IRIS " + full_name + "!")
    end
end
