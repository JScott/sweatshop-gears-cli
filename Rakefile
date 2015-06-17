require 'rake'
require 'rake/testtask'

task :bats do
  `sweatshop stop`
  $stdout.sync = true
  puts 'sweatshop-gears'
  IO.popen "bats #{__dir__}/test --pretty" do |io_stream|
    while line = io_stream.gets
      puts line
    end
  end
end

task :riot do
  Dir.glob('test/*_test.rb').each do |path|
    require_relative path
  end
end

task :build do
  print 'Building and installing local gem..'
  `gem build sweatshop_gears.gemspec --force`
  print '.'
  `gem install sweatshop_gears-*.gem`
  puts 'Done.'
end

task default: :test
task test: [:build, :riot]
