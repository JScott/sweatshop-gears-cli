require 'fileutils'
require 'terminal-announce'
require 'yaml'
require 'robot_sweatshop/config'

module Gears
  module Binaries
    def self.expose(from_path:)
      Gears.packages(from_path).each do |package|
        link package if contains_binary? package
      end
    end

    def self.contains_binary?(path)
      metadata = YAML.load File.read("#{path}/metadata.yaml")
      metadata['type'] == 'binary'
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
