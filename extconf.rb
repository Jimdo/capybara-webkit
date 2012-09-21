require File.join(File.expand_path(File.dirname(__FILE__)), "lib", "capybara_webkit_builder")
CapybaraWebkitBuilder.link_existing_binary_for_platform || CapybaraWebkitBuilder.build_all
