require 'fileutils'
require 'terminal-announce'
require 'erubis'

module Gears
  # Installs service Gears packages
  module Services
    def self.load(from_path:)
      service = File.basename from_path
      dynamically_load_eye service, from_path
      Announce.success "Loaded #{service} into Eye"
    end

    def self.write_and_load(eye_config)
      eye_file = '/tmp/.sweatshop_gears.eye'
      File.write eye_file, eye_config
      puts eye_config
      puts `eye load #{eye_file}`
      puts `eye stop sweatshop_gears`
      File.delete eye_file
    end

    def self.dynamically_load_eye(service, gears_path)
      input = File.read "#{__dir__}/sweatshop_gears.eye.eruby"
      eruby = Erubis::Eruby.new input
      context = { service: service, gears_path: File.expand_path(gears_path) }
      write_and_load eruby.result(context)
    end
  end
end
