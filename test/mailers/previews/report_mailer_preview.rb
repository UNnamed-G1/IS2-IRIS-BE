# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class ReportMailerPreview < ActionMailer::Preview

    def report_mail
        data = Hash.new
        data["users"] = User.with_publications_count
        data['total_publications']  = Publication.all.count
        data['report_description'] = "historial de aportes y numero
                                    de publicaciones"
        ReportMailer.report_mail(User.last, "asdasd", "../views/reports/users_report.pdf.erb", data) # recipient, report_name, template_path, reports_users
    end
end
