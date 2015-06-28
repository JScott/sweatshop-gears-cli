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
      puts `eye stop sweatshop_gears:services`
      File.delete eye_file
    end

    def self.installed_in(path)
      services = Dir.glob("#{path}/*").select { |path| File.directory? path }
      services.map { |path| File.basename path }
    end

    def self.parent_path_of(install_path)
      File.expand_path "#{install_path}/.."
    end

    def self.service_hub_path
      "#{__dir__}/../../../bin/sweatshop-gears-service-hub"
    end

    def self.dynamically_load_eye(install_path)
      services_path = parent_path_of install_path
      context = {
        config: Gears::Metadata.sweatshop_config,
        services: installed_in(services_path),
        services_path: File.expand_path(services_path),
        service_hub_bin: File.expand_path(service_hub_path)
      }
      input = File.read "#{__dir__}/sweatshop_gears.eye.eruby"
      eruby = Erubis::Eruby.new input
      write_and_load eruby.result(context)
    end

    def self.create_paths
      config = Gears::Metadata.sweatshop_config
      FileUtils.mkpath "#{config[:logfile_path]}/gears"
      FileUtils.mkpath "#{config[:pidfile_path]}/gears"
    end
  end
end
