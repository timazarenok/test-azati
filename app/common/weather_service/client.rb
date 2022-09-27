# frozen_string_literal: true

require 'singleton'
require 'http'

module WeatherService
  class Client
    include Singleton

    attr_accessor :service

    def initialize
      @service = HTTP.headers(base_headers)
    end

    private

    def base_headers
      {
        "x-api-key": api_key,
        "Content-type": "application/json"
      }
    end

    def api_key
      Rails.application.credentials.weather[:api_key]
    end
  end
end
