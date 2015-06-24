require 'terminal-announce'
require 'rake'
require 'rake/testtask'

task :riot do
  Dir.glob('test/*_test.rb').each do |path|
    require_relative path
  end
end

task :build do
  Announce.info 'Building and installing local gem...'
  puts `rm -rf sweatshop_gears-*.gem`
  puts `gem build sweatshop_gears.gemspec --force`
  puts `gem install sweatshop_gears-*.gem`
end

task default: :test
task test: [:build, :riot]
