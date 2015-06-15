require 'git'
require 'yaml'

# Provides information and downloading of Gears packages
module Gears
  def self.clone_packages(path)
    Git.clone git_repo, File.basename(path), path: File.dirname(path)
  end

  def self.git_repo
    'https://github.com/JScott/sweatshop-gears-packages.git'
  end

  def self.download(to_path:)
    puts "Downloading packages from '#{git_repo}'"
    clone_packages to_path
    Announce.success 'Packages downloaded'
  end

  def self.packages(gears_path)
    paths = Dir["#{gears_path}/*"].select { |path| File.directory? path }
    paths.map { |path| File.expand_path path }
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
end
