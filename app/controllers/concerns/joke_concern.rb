# frozen_string_literal: true

module JokeConcern
  require 'net/http'
  require 'uri'

  def get_joke
    uri = URI.parse('https://icanhazdadjoke.com/')
    request = Net::HTTP::Get.new(uri)
    request['Accept'] = 'application/json'

    req_options = {
      use_ssl: uri.scheme == 'https',
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    response.body
  end
end
