require 'sinatra/base'

module Sinatra
  # Sinatra helper for the Service Hub server
  module ServiceHub
    def self.frontpage_template
      File.read "#{__dir__}/templates/frontpage.html.erb"
    end

    helpers ServiceHub
  end
end
