require 'terminal-announce'

# Provides information and downloading of Gears packages
module Gears
  module Packages
    def self.clone(git_repo, to_path:)
      return if Dir.exist? to_path
      Git.clone git_repo, File.basename(to_path), path: File.dirname(to_path)
    end

    def self.metadata_for(package_name, path)
      metadata_file = "#{path}/#{package_name}.yaml"
      fail "Metadata for '#{package_name}' not found" unless File.exist? metadata_file
      YAML.load_file metadata_file
    end

    def self.install_to(install_path)
      case metadata['type']
      when 'script'
        Gears::Scripts.expose from_path: install_path
      when 'service'
        Gears::Services.load from_path: install_path
      else
        fail 'Unknown package type'
      end
    end

    def self.expose(plural_type, from_path:)
      namespace = Gears.const_get plural_type.capitalize.to_sym
      namespace.send :expose, from_path: from_path
    end

    def self.install(package_name, from_path:)
      metadata = metadata_for package_name, from_path
      plural_type = "#{metadata['type']}s"
      install_path = "#{from_path}/#{plural_type}/#{package_name}"
      clone metadata['repo'], to_path: install_path
      Gears::Dependencies.install from_path: install_path
      expose plural_type, from_path: install_path
      Announce.success "#{package_name} installed"
    rescue => error
      puts error
      Announce.failure 'Error occurred, rolling back installation'
      FileUtils.rm_rf install_path
    end
  end
end
