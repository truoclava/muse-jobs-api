class Api::V1::Companies
  class BriefSerializer < ActiveModel::Serializer
    attributes :id, :name, :size, :jobs_count

    def jobs_count
      object.jobs.count
    end
  end

  class FullSerializer < BriefSerializer
    attributes :description, :api_id, :api_source, :created_at, :updated_at

    has_many :locations, serializer: Api::V1::Location
    has_many :industries, serializer: Api::V1::Industry
    has_many :jobs, serializer: Api::V1::Jobs::BriefSerializer
  end

end
