require 'terminal-announce'

module Gears
  module Dependencies
    def self.install(from_path:)
      Gears.packages(from_path).each do |path|
        install_gems path
      end
    end

    def self.install_gems(package_path)
      gemfile = "#{package_path}/Gemfile"
      return unless File.exist? gemfile
      name = File.basename(package_path).split('/').last
      Announce.info "Installing gems for #{name}"
      puts `bundle install --gemfile #{gemfile}`
    end
  end
end
