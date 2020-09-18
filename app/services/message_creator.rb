require 'net/http'
require 'net/https'

class MessageCreator
  def self.send_message(message)
    provider1 = 'https://jo3kcwlvke.execute-api.us-west-2.amazonaws.com/dev/provider1'
    provider1 = 'https://jo3kcwlvke.execute-api.us-west-2.amazonaws.com/dev/provider2'

    uri = URI(provider1)

    parameters = { "to_number": message.to_number,
                   "message": message.message,
                   "callback_url": 'https://ex.com' }.to_json

    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path, initheader = { 'Content-Type' => 'application/json' })
    req.body = parameters
    res = https.request(req)
    response_hash = JSON.parse(res.body, symbolize_names: true)

    if res.code == '200'
      message.message_id = response_hash[:message_id]
      message.save
    else
      # try with other provider
    end
  end
end
