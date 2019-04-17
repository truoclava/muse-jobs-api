module Api::V1::Concerns::Pagination
  extend ActiveSupport::Concern

  def paginate(relation)
    relation.limit(per_page).offset(page * per_page)
  end

  def paginate_array(array)
    Kaminari.paginate_array(array).page(page + 1).per(per_page)
  end

  def page
    page = begin
             params[:page].to_i
           rescue NoMethodError
             0
           end

    [0, page].max
  end

  def per_page
    per_page = begin
                 params[:per_page].to_i
               rescue NoMethodError
                 10
               end

    per_page = 10 if per_page.zero?

    [1000, per_page].min
  end

  def pagination_meta
    { page: page, per_page: per_page }
  end
end
