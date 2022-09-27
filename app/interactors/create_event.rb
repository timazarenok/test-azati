class CreateEvent < BaseInteractor
  def call
    event = Event.new(event_params)
    event.user = context.user

    @result = WeatherService.call(date: event.date.to_s(:db))
    
    event.weather = weather if @result.success?

    context.fail!(notice: event.errors.full_messages.last) unless event.save
  end

  private

  attr_reader :result

  def event_params
    context.params
  end

  def weather
    [summary, celcius_temperature, precip_type].join(',')
  end

  def summary
    weather_data['summary']
  end

  def celcius_temperature
    return '' unless temperature

    celcius_temperature = (temperature - 32)

    return "+ #{celcius_temperature * (5/9)} C" if celcius_temperature > 0
    return "- #{celcius_temperature * (5/9)} C"
  end

  def temperature
    weather_data['temperature']
  end

  def precip_type
    weather_data['precipType']
  end

  def weather_data
    @weather_data ||= result.body['history'].first
  end
end
