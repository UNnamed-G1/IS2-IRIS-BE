class IncomingMailsController < ApplicationController
    before_action :authenticate_user

    def receive_comments
        data = comment_params
        user = User.find_by_email(data['email'])
        UserMailer.receive_comments_mail(data['subject'], user, data['comments']).deliver_now
        render json: ["Tus comentarios se han enviado correctamente a IRIS. Gracias por tus comentarios."], status: :ok
    end

    private
        def comment_params
            params.require(:comment).permit(:subject, :email, :comments)
        end

end