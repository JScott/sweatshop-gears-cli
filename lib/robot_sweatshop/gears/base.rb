require 'git'

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

  def self.packages(path)
    paths = Dir["#{path}/*"].select { |path| File.directory? path }
    paths.map { |path| File.expand_path path }
  end
end
