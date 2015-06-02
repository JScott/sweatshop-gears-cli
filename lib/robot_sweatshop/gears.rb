require 'contracts'
require 'git'
require 'terminal-announce'
require 'robot_sweatshop/config'

module Gears
  include Contracts

  Contract String => Git::Base
  def self.clone_packages(path)
    Git.clone git_repo, File.basename(path), path: File.dirname(path)
  end

  Contract Hash => Maybe[Git::Base]
  def self.download(to_path:)
    puts "Downloading packages from '#{git_repo}'"
    clone_packages to_path
    Announce.success 'Packages downloaded'
  end

  Contract None => String
  def self.git_repo
    'https://github.com/JScott/sweatshop-gears-packages.git'
  end

  Contract Hash => Any
  def self.expose_binaries(from_path:)
    puts "Linking '#{from_path}' to '#{configatron.scripts_path}'"
    packages(from_path).each { |package| expose package }
  end

  Contract String => nil
  def self.expose(package_path)
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

  Contract String => ArrayOf[String]
  def self.packages(path)
    paths = Dir["#{path}/*"].select { |path| File.directory? path }
    paths.map { |path| File.expand_path path }
  end

  Contract Hash => Any
  def self.install_dependencies(from_path:)
    packages(from_path).each do |path|
      install_gems path
    end
  end

  Contract String => Any
  def self.install_gems(package_path)
    gemfile = "#{package_path}/Gemfile"
    return unless File.exist? gemfile
    name = File.basename(package_path).split('/').last
    Announce.info "Installing gems for #{name}"
    puts `bundle install --gemfile #{gemfile}`
  end
end
