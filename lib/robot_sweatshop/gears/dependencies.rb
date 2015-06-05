require 'terminal-announce'
require 'bundler/cli'

module Gears
  module Dependencies
    def self.install(from_path:)
      Gears.packages(from_path).each { |path| install_gems path }
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
