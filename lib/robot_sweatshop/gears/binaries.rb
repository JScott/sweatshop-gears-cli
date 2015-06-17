require 'fileutils'
require 'terminal-announce'

module Gears
  # Installs binary Gears packages
  module Binaries
    def self.expose(from_path:)
      binary_name = File.basename from_path
      original_binary = File.expand_path "#{from_path}/#{binary_name}"
      binary_link = File.expand_path "#{scripts_path}/#{binary_name}"
      begin
        FileUtils.symlink original_binary, binary_link
        Announce.success "Symlinked #{binary_name}"
      rescue
        Announce.warning "#{binary_name} already exists"
      end
    end

    def self.scripts_path
      config = File.expand_path '~/.robot_sweatshop/compiled_config.yaml'
      fail 'Please run `sweatshop start` again' unless File.exist? config
      config = YAML.load File.read(config)
      config[:scripts_path]
    end
  end
end
