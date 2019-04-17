Rails.application.routes.draw do

  scope module: 'api', defaults: { format: 'json' } do
    scope 'v1', module: 'v1' do
      resources :companies, only: %i[index show]
      resources :jobs, only: %i[index show]
    end
  end
end
