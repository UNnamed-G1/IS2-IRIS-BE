class ResearchGroupMailer < ApplicationMailer

    def welcome_research_group(recipient, research_group)
        @user = recipient
        @research_group = research_group

        path_images = "/app/assets/images/mailers"
        attachments.inline['iris_logo.png'] = File.read("#{Rails.root}#{path_images}/IRIS_logo.png")
        attachments.inline['unal_logo.png'] = File.read("#{Rails.root}#{path_images}/UNAL_escudo.png")
        attachments.inline['research_group_picture.png'] = File.read("#{Rails.root}/public#{@research_group.photo.picture}")

        full_name = @user.name + " " + @user.lastname
        email_with_name = %("#{full_name}" <#{@user.email}>)
        puts "ASDADs"
        mail(to: email_with_name, subject: "Ahora eres miembro de #{@research_group.name} !")
    end

end
