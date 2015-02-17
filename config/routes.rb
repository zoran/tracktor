require "api_constraint"

Rails.application.routes.draw do
  namespace :tracktor, defaults: { format: :json }, path: "/" do
    scope module: "v1", constraints: ApiConstraint.new(version: 1) do
      resources :locations, via: [:options, :post], only: :create,
          constraints: ApiSubDomainConstraint.new(Rails.configuration.valid_subdomains)

      match "locations", to: "locations#options", via: [:options]
    end
  end
end
