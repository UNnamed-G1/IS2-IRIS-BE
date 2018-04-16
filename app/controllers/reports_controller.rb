class  ReportsController  <  ActionController::Base
  def group_history
	   @reports_rgs = ResearchGroup.all
  end
  def user_history
	   @reports_users = User.all
  end

  def show
    user_history
    #group_history
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: User.first.name, template: "../views/reports/users_report", layout: "pdf.html"
      end
    end
  end
end