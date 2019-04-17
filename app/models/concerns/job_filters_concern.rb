module JobFiltersConcern
  extend ActiveSupport::Concern

  included do
    scope :by_categories, lambda { |categories|
      if categories
        categories = categories.map(&:chomp)
        joins(:categories).where(categories: { name: categories })
      end
    }

    scope :by_locations, lambda { |locations|
      if locations
        locations = locations.map(&:chomp)
        joins(:locations).where(locations: { name: locations })
      end
    }

    scope :by_companies, lambda { |companies|
      if companies
        companies = companies.map(&:chomp)
        joins(:company).where(companies: { name: companies })
      end
    }

    scope :by_levels, lambda { |levels|
      if levels
        levels = [levels].flatten.map do |level|
          Job.levels[level] || nil
        end.compact

        where(level: levels)
      end
    }
  end
end
