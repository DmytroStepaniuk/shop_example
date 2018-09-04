require 'simplecov'

SimpleCov.start 'rails' do
  add_group 'Decorators', 'app/decorators'

  add_group 'Observers', 'app/observers'

  add_group 'Mailers', 'app/mailers'

  add_group 'Factories', 'app/factories'

  add_group 'Updaters', 'app/updaters'

  add_group 'Searches', 'app/searches'

  add_group 'Builders', 'app/builders'

  add_group 'Services', 'app/services'
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
