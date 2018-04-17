class UserMailer < ApplicationMailer

    def sign_up_confirmation(user)
        @user = user
        full_name = @user.name + " " + @user.lastname
        @url = 'https://is2-iris-fe.herokuapp.com/login'
        email_with_name = %("#{full_name}" <#{@user.email}>)
        mail(to: email_with_name, subject: "Bienvenido a IRIS " + full_name + "!")
    end

    def welcome_mail(user)
        @user = user
        full_name = @user.name + " " + @user.lastname
        email_with_name = %("#{full_name}" <#{@user.email}>)
        mail(to: email_with_name, subject: "Bienvenido a IRIS " + full_name + "!")
    end

    def receive_comments_mail(subject, remitent, comments)
        @remitent = remitent
        @comments = comments
        @subject = subject
        mail(to: 'iris.investigationgroups@gmail.com', subject: subject)
    end

    def new_follower(user, follower) 
        @user = user
        @follower = follower

        email_with_name = %("#{full_name}" <#{@user.email}>)
    end
end
