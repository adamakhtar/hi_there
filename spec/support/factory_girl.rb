require 'factory_girl_rails'

require 'hi_there/testing_support/factories'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end