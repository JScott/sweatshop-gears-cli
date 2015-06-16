require 'terminal-announce'
require 'bundler/cli'

module Gears
  # Deals with the dependencies from Gears packages
  module Dependencies
    def self.install(from_path:)
      install_gems from_path
    end

    def self.install_gems(package_path)
      gemfile = "#{package_path}/Gemfile"
      return unless File.exist? gemfile
      name = File.basename(package_path).split('/').last
      Announce.info "Installing gems for #{name}"
      system "bundle install --gemfile #{gemfile}"
    end
  end
end
