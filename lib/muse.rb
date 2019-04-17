class Muse

  include HTTParty

  ENDPOINT = 'https://www.themuse.com/api/public'

  def seed_jobs(location:, page: 0)
    query = {
      location: location,
      page: page
    }

    request('jobs', query)
  end

  private

  def request(function, query)
    Rails.logger.warn(['Muse.request', function, query.inspect].join(' '))

    response = HTTParty.get(
      [ENDPOINT, function].join('/'),
      query: query
    )

    Rails.logger.warn("Muse.response: #{response.inspect}")

    begin
      results = JSON.parse response.body
    rescue JSON::ParserError
      Rails.logger.warn("JSON::ParserError: #{response.body.inspect}")
      raise Error, 'failed http request: malformed json'
    end

  end

end
