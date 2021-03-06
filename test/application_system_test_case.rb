require "test_helper"
require "capybara/poltergeist"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app,:js_errors => false)
  end
  Capybara.javascript_driver = :poltergeist
  driven_by :poltergeist

end
