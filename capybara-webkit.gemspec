$:.push File.expand_path("../lib", __FILE__)
require "capybara/webkit/version"

Gem::Specification.new do |s|
  s.name     = "capybara-webkit"
  s.version  = Capybara::Driver::Webkit::VERSION.dup
  s.authors  = ["thoughtbot", "Joe Ferris", "Matt Mongeau", "Mike Burns", "Jason Morrison"]
  s.email    = "support@thoughtbot.com"
  s.homepage = "http://github.com/thoughtbot/capybara-webkit"
  s.summary  = "Headless Webkit driver for Capybara"

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- {spec,features}/*`.split("\n")
  s.require_path = "lib"

  webkit_server = `which webkit_server`.strip
  if webkit_server.empty?
    s.extensions = "extconf.rb"
  else
    FileUtils.ln_s(webkit_server, File.expand_path("../bin", __FILE__), :force => true)
    s.post_install_message = <<-MESSAGE
 !    Capybara-Webkit is using the webkit_server binary found at '#{webkit_server}'.
  MESSAGE
  end

  s.add_runtime_dependency("capybara", [">= 1.0.0", "< 1.2"])
  s.add_runtime_dependency("json")

  s.add_development_dependency("rspec", "~> 2.6.0")
  # Sinatra is used by Capybara's TestApp
  s.add_development_dependency("sinatra")
  s.add_development_dependency("mini_magick")
  s.add_development_dependency("rake")
  s.add_development_dependency("appraisal", "~> 0.4.0")
end

