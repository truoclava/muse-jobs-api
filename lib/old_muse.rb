class Muse

  include HTTParty

  def initialize
    @base_uri = 'https://www.themuse.com/api/public'
  end

  def seed_jobs(location:, page:)
    endpoint = '/jobs'
    query = {
      location: 'Hong Kong',
      page: page || 0
    }
    route = @base_uri + endpoint

    begin
      response = self.class.get(
        route,
        query: query
      )

      binding.pry

      data = JSON.parse response.body
    rescue => e
      Rails.logger.warn "Failed to seed"
      Rails.logger.warn e.message
      e.message.to_json
    end
  end

  private

  def request
  end

end
