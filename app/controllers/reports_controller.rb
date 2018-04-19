class  ReportsController  <  ActionController::Base
  include Knock::Authenticable
  #before_action :authenticate_user

  def show(temp_path, pdf_name)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: pdf_name, template: temp_path, layout: "pdf.html"
      end
    end
  end

  def total_user_history
    @reports_users = User.with_publications_count
    template_s = "../views/reports/users_report"
    pdf_name = "Users reports"
    show(template_s, pdf_name)
  end

  def total_rgs_history
    @reports_rgs = ResearchGroup.with_publications_count
    template_s = "../views/reports/rgs_report"
    pdf_name = "RGS reports"
    show(template_s, pdf_name)
  end

  def history_by_user
    id_user = params[:id]
    @report_by_user = Publication.search_publications_by_user(id_user)
    template_s = "../views/reports/rep_by_user"
    @par = id_user
    @pdf_name = "Report_User #{id_user}"
    show(template_s, @pdf_name)
  end

  def history_by_rg
    id_rg = params[:id]
    @report_by_rg = Publication.search_publications_by_rg(id_rg)
    template_s = "../views/reports/rep_by_rg"
    @par = id_rg
    @pdf_name = "Report_RG #{id_rg}"
    show(template_s, @pdf_name)
  end

  private
  # Method for change the message when user is unauthorized
  def unauthorized_entity(entity_name)
    render json: ["You are unauthorized to access this."], status: :unauthorized
  end

end
