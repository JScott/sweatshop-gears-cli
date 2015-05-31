RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # config.warnings = true
  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed
  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
  # # These two settings work together to allow you to limit a spec run
  # # to individual examples or groups you care about by tagging them with
  # # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # # get run.
  # config.filter_run :focus
  # config.run_all_when_everything_filtered = true

  # # Print the 10 slowest examples and example groups at the
  # # end of the spec run, to help surface which specs are running
  # # particularly slow.
  # config.profile_examples = 10
end
