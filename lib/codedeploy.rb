require 'json'
require 'pp'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/string/inflections'

module Codedeploy
  AWS_DEFAULT_REGION = ENV['AWS_DEFAULT_REGION'] || 'us-east-1'
  DEBUG = ENV['DEBUG'] || false
  DEBUG_AWS = ENV['DEBUG_AWS'] || false
end

