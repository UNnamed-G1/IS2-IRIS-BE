class  ReportsController  <  ActionController::Base
  include Knock::Authenticable
  before_action :authenticate_user

  TEMPLATES_PATH = "../views/reports"

  def group_history
	   @reports_rgs = ResearchGroup.all
  end

  def show(template, pdf_name)
    template_path = TEMPLATES_PATH + template
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: pdf_name, template: template_path, layout: "pdf.html"
      end
    end
  end

  def send_report(report_name, template, value_report)
    template_path = TEMPLATES_PATH + template
    UserMailer.report_mail(current_user, pdf_name, template_path, value_report).deliver_now
    render json: {"message": "Acción realizada satisfactoriamente"}, status: :ok
  end

  def total_user_history
    reports_users = User.all
    template = "/users_report.pdf.erb"
    pdf_name = "Users reports"

    if params[:send] == "true"
      send_report(pdf_name, template, reports_users)
    else
      @reports_users = reports_users
      show(template, pdf_name)
    end 
  end

  def total_rgs_history
    reports_rgs = ResearchGroup.all
    template_path = TEMPLATES_PATH + "/rgs_report"
    pdf_name = "RGS reports"

    # if params[:send] == "true"
    #   UserMailer.report_mail(current_user, pdf_name, template_path, reports_rgs).deliver_now
    #   render json: {"message": "Acción realizada satisfactoriamente"}, status: :ok
    # else
      @reports_rgs = reports_rgs
      show(template_path, pdf_name)
    # end 
  end

  def history_by_user
    id_user = params[:id]
    @report_by_user = Publication.search_publications_by_user(id_user)
    template = "/rep_by_user.pdf.erb"
    @par = id_user
    @pdf_name = "Report_User #{id_user}"
    show(template, @pdf_name)
  end

  def history_by_rg
    id_user = params[:id]
    @report_by_rg = Publication.search_publications_by_rg(id_user)
    template_s = "../views/reports/rep_by_rg"
    @par = id_user
    @pdf_name = "Report_RG #{id_user}"
    show(template_s, @pdf_name)
  end
  
  private
  # Method for change the message when user is unauthorized
  def unauthorized_entity(entity_name)
    render json: ["You are unauthorized to access this."], status: :unauthorized
  end

end
