require 'fileutils'
require 'terminal-announce'
require 'erubis'

module Gears
  # Installs Gears service packages
  module Services
    def self.expose(from_path:)
      service = File.basename from_path
      dynamically_load_eye from_path
      Announce.success "Loaded #{service} into Eye"
    end

    def self.write_and_load(eye_config)
      eye_file = '/tmp/.sweatshop_gears.eye'
      File.write eye_file, eye_config
      puts `eye load #{eye_file}`
      puts `eye stop sweatshop_gears`
      File.delete eye_file
    end

    def self.services_installed_to(install_path)
      paths = Dir["#{install_path}/*"].select { |path| File.directory? path }
      paths.map { |path| File.basename path }
    end

    def self.parent_path_of(install_path)
      File.expand_path "#{install_path}/.."
    end

    def self.dynamically_load_eye(install_path)
      context = {
        services: services_installed_to(parent_path_of(install_path)),
        install_path: File.expand_path(install_path)
      }
      input = File.read "#{__dir__}/sweatshop_gears.eye.eruby"
      eruby = Erubis::Eruby.new input
      write_and_load eruby.result(context)
    end
  end
end
