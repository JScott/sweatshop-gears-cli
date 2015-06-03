require 'fileutils'
require 'terminal-announce'
require 'erubis'

module Gears
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

    def self.dynamically_load_eye(service_list, gears_path)
      input = File.read "#{__dir__}/sweatshop_gears.eye.eruby"
      eruby = Erubis::Eruby.new input
      eye_file = '/tmp/.sweatshop_gears.eye'
      File.write eye_file, eruby.result(services: service_list, gears_path: File.expand_path(gears_path))
      puts `eye load #{eye_file}`
    end
  end
end
