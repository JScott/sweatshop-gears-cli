# Helper methods for the Service Hub Sinatra server
module Gears
  module ServiceHub
    def frontpage_template
      File.read "#{__dir__}/templates/frontpage.html.eruby"
    end
  end
end
