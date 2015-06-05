require 'fileutils'
require 'terminal-announce'

module Gears
  # Installs binary Gears packages
  module Binaries
    def self.expose(from_path:)
      Gears.packages(from_path).each do |package|
        link package if contains_binary? package
      end
    end

    def self.contains_binary?(package_path)
      metadata = Gears.metadata package_path
      metadata['type'] == 'binary'
    end

    def self.link(package_path)
      binary_name = File.basename package_path
      original_binary = "#{package_path}/#{binary_name}"
      binary_link = "#{scripts_path}/#{binary_name}"
      begin
        FileUtils.symlink original_binary, binary_link
        Announce.success "Symlinked #{binary_name}"
      rescue
        Announce.warning "#{binary_name} already exists"
      end
    end

    def self.scripts_path
      sweatshop_config = '/tmp/.robot_sweatshop-eye-config.yaml'
      Announce.failure 'Please run `sweatshop start` again' unless File.exist? sweatshop_config
      config = YAML.load File.read(sweatshop_config)
      config[:scripts_path]
    end
  end
end
