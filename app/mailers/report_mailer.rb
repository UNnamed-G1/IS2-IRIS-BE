class ReportMailer < ApplicationMailer

    def report_mail(recipient, report_name, template_path, data)
        @recipient = recipient
        @data = data
        path_images = "/app/assets/images/mailers"
        attachments.inline['iris_logo.png'] = File.read("#{Rails.root}#{path_images}/IRIS_logo.png")
        attachments.inline['unal_logo.png'] = File.read("#{Rails.root}#{path_images}/UNAL_escudo.png")

        report = WickedPdf.new.pdf_from_string(render_to_string(pdf: report_name, template: template_path, layout: "pdf.html"))

        attachments["#{report_name}.pdf"] = report
        
        full_name = @recipient.name + " " + @recipient.lastname
        email_with_name = %("#{full_name}" <#{@recipient.email}>)
        mail(to: email_with_name, subject: "Reporte de " + data["report_description"])
    end
end