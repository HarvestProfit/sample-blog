source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "rails", "~> 6.1.3", ">= 6.1.3.1"

gem "api-pagination"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", ">= 1.4.4", require: false
gem "commonmarker"
gem "github-markup"
gem "image_processing", "~> 1.2"
gem "jbuilder", "~> 2.7"
gem "kaminari"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rack-cors"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "codecov"
  gem "simplecov"
  gem "standard"
end

group :development do
  gem "listen", "~> 3.3"
  gem "spring"
end
