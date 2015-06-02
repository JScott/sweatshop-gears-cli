require 'rake'

task :test do
  IO.popen "bats #{__dir__}/test --pretty" do |file|
    until file.eof?
      puts file.gets
    end
  end
end

task :default => :test
