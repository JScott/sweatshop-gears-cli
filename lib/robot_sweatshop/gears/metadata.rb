require 'git'
require 'yaml'
require 'terminal-announce'
require 'fileutils'

# Provides information and downloading of Gears metadata
module Gears
  module Metadata
    def self.clone(path)
      Git.clone git_repo, File.basename(path), path: File.dirname(path)
    end

    def self.git_repo
      'https://github.com/JScott/sweatshop-gears-packages.git'
    end

    def self.download(to_path:)
      puts "Downloading metadata from '#{git_repo}'"
      clone to_path
      Announce.success 'Metadata downloaded'
    end

    def self.metadata(package_path)
      YAML.load File.read("#{package_path}/metadata.yaml")
    end

    def self.sweatshop_config
      path = File.expand_path '~/.robot_sweatshop/compiled_config.yaml'
      fail 'Please run `sweatshop start` first' unless File.exist? path
      YAML.load File.read(path)
    end
  end
end
