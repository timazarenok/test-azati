class Response
  def initialize(**args)
    @response = args[:response] || ''
  end

  def success?
    return false unless response
    return false if response.code.between?(400, 499)

    true
  end

  def body
    JSON.parse(response.body)["data"]
  end

  private

  attr_reader :response
end
