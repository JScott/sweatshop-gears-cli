require 'fileutils'
require 'terminal-announce'
require 'robot_sweatshop/config'

module Gears
  module Binaries
    def self.expose(from_path:)
      puts "Linking '#{from_path}' to '#{configatron.scripts_path}'"
      Gears.packages(from_path).each { |package| link package }
    end

    def self.link(package_path)
      binary_name = File.basename package_path
      original_binary = "#{package_path}/#{binary_name}"
      binary_link = "#{configatron.scripts_path}/#{binary_name}"
      begin
        FileUtils.symlink original_binary, binary_link
        Announce.success "Symlinked #{binary_name}"
      rescue
        Announce.warning "#{binary_name} already exists"
      end
    end
  end
end
