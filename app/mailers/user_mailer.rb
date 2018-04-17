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

    def new_follower_mail(followed, follower) 
        @followed = followed
        @follower = follower
        # Mark this mail as no-spam
        headers({'X-No-Spam' => 'True', 'In-Reply-To' => 'complaints@dontcare.com'})
        path_images = "/app/assets/images/mailers"
        attachments.inline['iris_logo.png'] = File.read("#{Rails.root}#{path_images}/IRIS_logo.png")
        attachments.inline['unal_logo.png'] = File.read("#{Rails.root}#{path_images}/UNAL_escudo.png")
        attachments.inline['profile_image_default.png'] = File.read("#{Rails.root}#{path_images}/user_default.png")
        if @follower.photo
            attachments.inline['profile_image.png'] = File.read("#{Rails.root}/public#{@follower.photo.picture.url}")
        end
        full_name = @followed.name + " " + @followed.lastname
        email_with_name = %("#{full_name}" <#{@followed.email}>)
        mail(to: email_with_name, subject: "Tienes un nuevo seguidor!!")
    end
end
