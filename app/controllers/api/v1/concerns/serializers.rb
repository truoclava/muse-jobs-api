module Api::V1::Concerns::Serializers
  extend ActiveSupport::Concern

  DEFAULT_SERIALIZER_OPTIONS = {
    adapter: 'json',
    root: 'data'
  }

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
