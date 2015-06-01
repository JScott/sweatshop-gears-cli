require 'contracts'
require 'git'
require 'terminal-announce'
require 'robot_sweatshop/config'

module Tears
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
    'https://github.com/JScott/sweatshop-tears-packages.git'
  end

  Contract Hash => Any
  def self.expose_binaries(from_path:)
    puts "Linking '#{from_path}' to '#{configatron.scripts_path}'"
    scripts(from_path).each { |script| expose script }
  end

  Contract String => nil
  def self.expose(path)
    binary_name = File.basename path
    original_binary = "#{path}/#{binary_name}"
    binary_link = "#{configatron.scripts_path}/#{binary_name}"
    begin
      FileUtils.symlink original_binary, binary_link
      Announce.success "Symlinked #{binary_name}"
    rescue
      Announce.warning "#{binary_name} already exists"
    end
  end

  Contract String => ArrayOf[String]
  def self.scripts(path)
    paths = Dir["#{path}/*"].select { |path| File.directory? path }
    paths.map { |path| File.expand_path path }
  end
end
