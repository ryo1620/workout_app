require 'capybara/rspec'

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: {
      args: %w[--headless --no-sandbox --disable--gpu --window-size=1280x800]
    }
  )
  opts = { desired_capabilities: capabilities, browser: :remote, url: ENV['SELENIUM_REMOTE_URL'] }
  Capybara::Selenium::Driver.new(app, opts)
end

Capybara.server_host = '0.0.0.0'
Capybara.javascript_driver = :headless_chrome

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :headless_chrome
    Capybara.app_host = "http://#{Socket.gethostname}"
  end
end