class  ReportsController  <  ActionController::Base

  def group_history
	   @reports_rgs = ResearchGroup.all
  end

  def show(temp_path, pdf_name)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: pdf_name, template: temp_path, layout: "pdf.html"
      end
    end
  end

  def total_user_history
    @reports_users = User.all
    template_s = "../views/reports/users_report"
    pdf_name = "Users reports"
    show(template_s, pdf_name)
  end

  def total_rgs_history
    @reports_rgs = ResearchGroup.all
    template_s = "../views/reports/rgs_report"
    pdf_name = "RGS reports"
    show(template_s, pdf_name)
  end

  def history_by_user
    @report_by_user = Publication.search_publications_by_user(params[:id])
    template_s = "../views/reports/rep_by_user"
    @pdf_name = "#{User.search_users_by_id(params[:id])}"
    show(template_s, @pdf_name)
  end

  def history_by_rg
    @report_by_rg = Publication.search_publications_by_rg(params[:id])
    template_s = "../views/reports/rep_by_rg"
    pdf_name = "Report"
    show(template_s, pdf_name)
  end

end
