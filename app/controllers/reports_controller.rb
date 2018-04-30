class ReportsController < ActionController::Base
  include Knock::Authenticable
  #before_action :authenticate_user

  BASE_TEMPLATE_PATH = "../views/reports"

  def show(template, pdf_name)
    template_path = BASE_TEMPLATE_PATH + template

    respond_to do |format|
      format.html
      format.pdf do
        response.headers["Access-Control-Expose-Headers"] = "Accept-Ranges"
        render pdf: pdf_name, template: template_path, layout: "pdf.html", footer: { right: '[page] of [topage]' }
      end
    end
  end

  def send_report(report_name, template, data)
    template_path = BASE_TEMPLATE_PATH + template
    ReportMailer.report_mail(current_user, report_name, template_path, data).deliver_now
    render json: {"message": "Acción realizada satisfactoriamente"}, status: :ok
  end

  def total_user_history
    data = Hash.new
    data['users'] = User.with_publications_count
    data['total_publications'] = Publication.all.count
    
    template = "/users_report"
    pdf_name = "Users reports"
    
    if params[:send] == "true"
      data['report_description'] = "historial de aportes y numero
                                    de publicaciones"
      send_report(pdf_name, template, data)
    else
      @data = data
      show(template, pdf_name)
    end
  end

  def total_rgs_history
    data = Hash.new
    data["research_groups"] = ResearchGroup.with_publications_count
    data["total_publications"] = Publication.all.count

    template = "/rgs_report"
    pdf_name = "Research Groups"

    if params[:send] == "true"
      data["report_description"] = "historial de aportes y número de publicaciones"
      send_report(pdf_name, template, data)
    else
      @data = data
      show(template, pdf_name)
    end
  end

  def history_by_user
    data = Hash.new
    user_id = params[:id]
    data['user'] = User.find_by_id(user_id)
    data["publications"] = Publication.search_publications_by_user(user_id)
    data["stats_publication"] = Array.new
    publication_types = Publication.type_pubs.values 
    for publication_type in publication_types do
      data["stats_publication"][publication_type] = Publication.num_publications_by_user_and_type(user_id, publication_type)
    end

    template = "/rep_by_user"
    pdf_name = "Report_User #{user_id}"

    if params[:send] == "true"
      data["report_description"] = "publicaciones hechas por usuario"
      send_report(pdf_name, template, data)
    else
      @data = data
      show(template, pdf_name)
    end
  end

  def history_by_rg
    user_id = params[:id]
    data = Hash.new
    data["publications"] = Publication.search_publications_by_rg(user_id)
    data["research_group_name"] = ResearchGroup.find_by_id(user_id).name
    data["stats_publication"] = Array.new
    publication_types = Publication.type_pubs.values 
    for publication_type in publication_types do
      data["stats_publication"][publication_type] = Publication.num_publications_by_rg_and_type(user_id, publication_type)
    end
    puts data
    template = "/rep_by_rg.pdf.erb"
    pdf_name = "Report_Research_Group #{user_id}"
    
    if params[:send] == "true"
      data["report_description"] = "publicaciones realizada por un
                                    Grupo de Investigación"
      send_report(pdf_name, template, data)
    else
      @data = data
      show(template, pdf_name)
    end
  end

  private

  # Method for change the message when user is unauthorized
  def unauthorized_entity(entity_name)
    render json: ["You are unauthorized to access this."], status: :unauthorized
  end
end
