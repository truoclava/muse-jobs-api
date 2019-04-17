class Muse

  include HTTParty

  ENDPOINT = 'https://www.themuse.com/api/public'

  def fetch_jobs(location: nil, page: 0, company: nil)
    query = {
      page: page
    }

    query.merge!(company: company) if company
    query.merge!(location: location) if location
    request('jobs', query)
  end

  def fetch_companies(location: 'Hong Kong', page: 0)
    query = {
      location: location,
      page: page
    }

    request('companies', query)
  end


  private

  def request(function, query)
    Rails.logger.warn(['Muse.request', function, query.inspect].join(' '))

    response = HTTParty.get(
      [ENDPOINT, function].join('/'),
      query: query
    )

    # Rails.logger.warn("Muse.response: #{response.inspect}")

    begin
      results = JSON.parse response.body
    rescue JSON::ParserError
      Rails.logger.warn("JSON::ParserError: #{response.body.inspect}")
      raise Error, 'failed http request: malformed json'
    end

  end

end
