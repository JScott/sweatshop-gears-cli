require 'fileutils'
require 'terminal-announce'

module Gears
  # Installs Gears script packages
  module Scripts
    def self.expose(from_path:)
      script_name = File.basename from_path
      original_script = File.expand_path "#{from_path}/#{script_name}"
      script_link = File.expand_path "#{scripts_path}/#{script_name}"
      begin
        FileUtils.symlink original_script, script_link
        Announce.success "Symlinked #{script_name}"
      rescue
        Announce.warning "#{script_name} already exists"
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
