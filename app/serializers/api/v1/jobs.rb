class Api::V1::Jobs
  class BriefSerializer < ActiveModel::Serializer
    attributes :id, :title, :level, :short_description

    has_one :company, serializer: Api::V1::Companies::BriefSerializer
    has_many :locations, serializer: Api::V1::Location

    def short_description
      stripped = ActionView::Base.full_sanitizer.sanitize(object.description).squish
      stripped.first(100)
    end
  end

  class FullSerializer < BriefSerializer
    attributes :description, :api_id, :api_source, :created_at, :updated_at

    has_many :categories, serializer: Api::V1::Category

  end

end
