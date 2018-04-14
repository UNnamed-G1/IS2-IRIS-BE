class  ReportsController  <  ActionController::Base
  def user_history
	   @reports = ResearchGroup.all
  end
  def group_history
	   #@reports = Publication.search_publications_by_rg(params[:id])
  end
  def show
    user_history
    #group_history
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: User.first.name, template: "../views/reports/rgs_report", layout: "pdf.html"
      end
    end
  end
end
