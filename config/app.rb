Terraspace.configure do |config|
  config.logger.level = :info
  config.test_framework = "rspec"

  # Setting `clean_cache = false` disables cleaning the .terraspace-cache between runs.
  # This allows terraspace all up to work where there are modules that generate local files.
  # Wondering if relying on generated local files from different stacks is an good, okay, or bad thing.
  config.build.clean_cache = false
end
