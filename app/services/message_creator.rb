require 'net/http'
require 'net/https'

class MessageCreator

  def initialize(message)
    @message = message
    @providers_down = []
    @loop = false
  end

  def send_message
    provider = Provider.ready_to_use(self)

    if provider.nil?
      @message.status = 'failed'
      @message.save
      return
    end

    if !call(provider)
      @providers_down.push(provider.id)
      send_message
    end
  end

  def call(provider)
    uri = URI(provider.url)

    parameters = { "to_number": @message.to_number,
                  "message": @message.message,
                  "callback_url": 'https://ex.com' }.to_json

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = { 'Content-Type' => 'application/json' })
    req.body = parameters
    res = https.request(req)
    response_hash = JSON.parse(res.body, symbolize_names: true)

    if res.code == '200'
      @message.message_id = response_hash[:message_id]
      @message.provider_id = provider.id
      @message.save
      true
    else
      false
    end
  end

  def providers_down
    @providers_down
  end

  def reset_providers_down
    @providers_down = []
    @loop = true
  end

  def loop
    @loop
  end
end
