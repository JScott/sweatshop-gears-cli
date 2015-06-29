require 'fileutils'
require 'terminal-announce'
require 'erubis'

module Gears
  # Installs Gears service packages
  module Services
    def self.expose(from_path:)
      services_path = File.expand_path "#{from_path}/.."
      dynamically_load_eye_from services_path
      service = File.basename from_path
      Announce.success "Loaded #{service} into Eye"
    end

    def self.write_and_load(eye_config)
      File.write eye_file, eye_config
      puts `eye load #{eye_file}`
      puts `eye stop sweatshop_gears`
    end

    def self.installed_in(path)
      services = Dir.glob("#{path}/*").select { |path| File.directory? path }
      services.map { |path| File.basename path }
    end

    def self.eye_file
      '/tmp/.sweatshop_gears.eye'
    end

    def self.first_port
      34871
    end

    def self.dynamically_load_eye_from(services_path)
      context = {
        config: Gears::Metadata.sweatshop_config,
        services: installed_in(services_path),
        services_path: services_path,
        first_port: first_port
      }
      input = File.read "#{__dir__}/templates/sweatshop_gears.eye.eruby"
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
