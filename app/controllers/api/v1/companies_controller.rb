class Api::V1::CompaniesController < Api::V1Controller

  def index
    render json: respond_with_companies
  end

  def show
    company = Company.find(params[:id])
    render json: serialized(company, serializer: Api::V1::Companies::FullSerializer)
  end

  private

  def respond_with_companies
    companies = Company.all
    paginated = paginate(companies)
    paginated = load_includes(paginated)

    serialized(
      paginated,
      serializer: Api::V1::Companies::BriefSerializer,
      meta: {
        total_count: companies.count,
        per_page: per_page,
        total_pages: companies.count/per_page
      }
    )
  end

  def load_includes companies
    companies.includes(:jobs, :industries)
  end

end
