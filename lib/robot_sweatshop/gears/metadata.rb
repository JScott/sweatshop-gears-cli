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

    def self.create_runtime_paths
      config_path = File.expand_path '~/.robot_sweatshop/compiled_config.yaml'
      config = YAML.load_file config_path
      FileUtils.mkpath config[:logfile_path]
      FileUtils.mkpath config[:pidfile_path]
    end

    def self.download_and_install(package_name, from_path:)
      metadata_path = "#{from_path}/#{package_name}.yaml"
      fail "#{package_name} not found" unless File.exist? metadata_path
      metadata = YAML.load_file metadata_path
      Gears::Package.install_from metadata
    end
  end
end