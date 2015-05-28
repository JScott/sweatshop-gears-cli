require 'bundler/setup'
require 'simplecov'

task :test do
  SimpleCov.start do
    add_filter "/test/"
  end
  require_relative 'test/all'
end
