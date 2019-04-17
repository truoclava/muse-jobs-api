namespace :db do
  desc 'Seed data for Job Board from Muse Public API'

  task seed_muse_data: :environment do
    Rails.logger.info "Fetching companies from Hong Kong"
    companies = Muse.new.fetch_companies(location: 'Hong Kong')
    companies['results'].each do |company|
      params = {
        name: company['name'],
        size: company['size']['short_name'],
        description: company['description'],
        industries_attributes: company['industries'],
        locations_attributes: company['locations'],
        api_id: company['id'],
        api_source: 'The Muse'
      }

      object = Company.new(params)
      object.save
      p "Company: #{object.name} seeded"
    end

    Company.where(api_source: 'The Muse').each do |company|
      jobs = Muse.new.fetch_jobs(company: company.name)
      jobs['results'].each do |job|
        params = {
          title: job['name'],
          description: job['contents'],
          level: job['levels'].try(:first).try(:[], 'short_name'),
          locations_attributes: job['locations'],
          categories_attributes: job['categories'],
          api_id: job['id'],
          api_source: 'The Muse',
          published: true
        }
        company.jobs.new(params)
      end
      company.save
      p "Jobs for #{company.name} seeded"
    end
  end
end
