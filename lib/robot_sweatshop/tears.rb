require 'contracts'
require 'git'
require 'terminal-announce'
require 'robot_sweatshop/config'

module Tears
  include Contracts

  #     repo = Git.open download_path
  #     puts repo.pull

  Contract String => Git::Base
  def self.clone_packages_to(path)
    Git.clone git_repo, 'sweatshop-tears-packages', path: File.expand_path(path)
  end

  Contract String => Maybe[Git::Base]
  def self.download(path)
    return nil if Dir.exist? path
    Announce.info "Downloading packages from #{git_repo}"
    clone_packages_to path
  end

  Contract None => String
  def self.git_repo
    'git@github.com:JScott/sweatshop-tears-packages.git'
  end
end
