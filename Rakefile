require 'rake'

task :test do
  `sweatshop stop`
  $stdout.sync = true
  puts 'sweatshop-gears'
  IO.popen "bats #{__dir__}/test --pretty" do |io_stream|
    while line = io_stream.gets
      puts line
    end
  end
end

task :build do
  print 'Building and installing local gem..'
  `gem build sweatshop-gears.gemspec --force`
  print '.'
  `gem install robot_sweatshop-gears-*.gem`
  puts 'Done.'
end

task default: :test
task test: :build
