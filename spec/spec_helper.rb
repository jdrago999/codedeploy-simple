# Did we get executed via 'rake'?
is_rake_exec = $0 =~ /\/rake/

unless is_rake_exec
  ENV['RACK_ENV'] = 'test'
  require 'simplecov'
  SimpleCov.start do
    add_filter '.vendor/'
    add_filter 'spec/'
  end
  SimpleCov.minimum_coverage 100
end

require 'rspec'
require 'bundler'
require 'shoulda-matchers'
require 'byebug'
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dotenv'
Dotenv.load
require 'codedeploy'

Bundler.load

def configure_rspec
  require 'codedeploy/rspec_matchers'

  RSpec.configure do |config|

    config.expect_with :rspec do |expectations|
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
      # Allow foo.should syntax:
      expectations.syntax = [:should, :expect]
    end

    config.mock_with :rspec do |mocks|
      mocks.syntax = [:should, :expect]
      mocks.verify_partial_doubles = true
    end

    config.before :suite do
      # Delete any test stacks:
    end

    config.after :suite do
      # Delete any test stacks:
    end

    config.run_all_when_everything_filtered = true

    config.warnings = true

    if config.files_to_run.one?
      config.default_formatter = 'doc'
    end

    config.order = :random

    Kernel.srand config.seed
  end
end


unless is_rake_exec
  configure_rspec()
end
