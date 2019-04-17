class Api::V1::JobsController < Api::V1Controller

  def index
    render json: respond_with_jobs
  end

  def show
    job = Job.find(params[:id])
    render json: serialized(job, serializer: Api::V1::Jobs::FullSerializer)
  end

  private

  def respond_with_jobs
    jobs = scoped_jobs(default_scope)
    paginated = paginate(jobs)
    paginated = load_includes(paginated)

    serialized(
      paginated,
      serializer: Api::V1::Jobs::BriefSerializer,
      meta: {
        total_count: jobs.count,
        per_page: per_page,
        total_pages: jobs.count/per_page
      }
    )
  end

  def load_includes jobs
    jobs.includes(:categories, :company)
  end

  def default_scope
    params[:include_unpublished] ? Job.all : Job.published
  end

  def scoped_jobs(scope = nil)
    scope
    .by_levels(params[:levels])
    .by_companies(params[:companies])
    .by_locations(params[:locations])
    .by_categories(params[:categories])
  end

end
