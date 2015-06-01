require 'contracts'
require 'git'
require 'terminal-announce'
require 'robot_sweatshop/config'

module Tears
  include Contracts

  #     repo = Git.open download_path
  #     puts repo.pull

  Contract String => Git::Base
  def self.clone_packages(path)
    Git.clone git_repo, File.basename(path), path: File.dirname(path)
  end

  Contract Hash => Maybe[Git::Base]
  def self.download(to_path:)
    Announce.info "Downloading packages from '#{git_repo}'"
    clone_packages to_path
    Announce.success 'Packages downloaded'
  end

  Contract String => Any
  def self.expose_scripts!(from_path:)
    Announce.info "Linking '#{from_path}' to '#{configatron.scripts_path}'"
    # binaries.each do |binary| { create_link_to binary }
    # services.each do |service| { load_into_eye service }
  end

  Contract None => String
  def self.git_repo
    'git@github.com:JScott/sweatshop-tears-packages.git'
  end
end
