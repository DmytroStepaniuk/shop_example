source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{ repo_name.include?('/') ? "#{repo_name}/#{repo_name}" : repo_name }.git" }

gem 'rails', '~> 5.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma'
gem 'bcrypt'
gem 'draper'
gem 'kaminari'

group :development, :test do
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'pry-byebug'

  gem 'rails-erd'
  gem 'railroady'
end

group :development do
  gem 'listen'
end

group :test do
  gem 'rspec-its'
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers'
  gem 'simplecov', require: false
  gem 'rails-controller-testing'
  gem 'rspec-activemodel-mocks'
end
