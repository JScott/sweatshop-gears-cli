require 'rake'

task :test do
  puts "sweatshop-gears"
  IO.popen "bats #{__dir__}/test --pretty" do |file|
    until file.eof?
      puts file.gets
    end
  end
end

task :build do
  print 'Building and installing local gem...'
  `gem build sweatshop-gears.gemspec --force`
  `gem install robot_sweatshop-gears-*.gem`
  puts 'Done.'
end

task :default => :test
task :test => :build
