# frozen_string_literal: true

module WeatherService
  module_function

  # in feature connect to geo gem and save geo to user model
  # and put it into call method like args

  def call(**args)
    response = Client.instance.service.get(url, params: {
      lat: 53.893009,
      lng: 27.567444,
      from: args[:date],
      to: args[:date]
    })

    Response.new(response: response)
  end

  private

  def self.url
    'https://api.ambeedata.com/weather/history/by-lat-lng'
  end
end
