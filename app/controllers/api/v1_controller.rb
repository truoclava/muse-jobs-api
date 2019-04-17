class Api::V1Controller < ApplicationController

  DEFAULT_SERIALIZER_OPTIONS = {
    adapter: 'json',
    root: 'data'
  }

  def paginate(relation)
    relation.limit(per_page).offset(page * per_page)
  end

  # def paginate_array(array)
  #   Kaminari.paginate_array(array).page(page + 1).per(per_page)
  # end

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

  def serialized(data, options = {})
    serializer = options.delete(:serializer)

    if data.is_a?(Array) || data.is_a?(ActiveRecord::Relation)
      options[:each_serializer] = serializer if serializer
    elsif serializer
      options[:serializer] = serializer
    end

    data = { data: data } unless options[:serializer] || options[:each_serializer]
    options[:json] = data

    render_to_string({}.merge(DEFAULT_SERIALIZER_OPTIONS).merge(options))
  end


end
