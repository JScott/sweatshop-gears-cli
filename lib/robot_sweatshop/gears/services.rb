require 'fileutils'
require 'terminal-announce'
require 'erubis'

module Gears
  # Installs service Gears packages
  module Services
    def self.load(from_path:)
      packages = Gears.packages(from_path).select { |package| contains_service? package }
      services = packages.map { |package| File.basename package }
      dynamically_load_eye services, from_path
      services.each { |service| Announce.success "Loaded #{service} into Eye" }
    end

    def self.contains_service?(package_path)
      metadata = Gears.metadata package_path
      metadata['type'] == 'service'
    end

    def self.write_and_load(eye_config)
      eye_file = '/tmp/.sweatshop_gears.eye'
      File.write eye_file, eye_config
      puts `eye load #{eye_file}`
      puts `eye stop sweatshop_gears`
      File.delete eye_file
    end

    def self.dynamically_load_eye(service_list, gears_path)
      input = File.read "#{__dir__}/sweatshop_gears.eye.eruby"
      eruby = Erubis::Eruby.new input
      context = { services: service_list, gears_path: File.expand_path(gears_path) }
      write_and_load eruby.result(context)
    end
  end
end
