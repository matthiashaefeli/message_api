require 'rails_helper'

RSpec.describe 'Message', type: :request do
  describe 'index' do
    it 'returns all messages of certain to_number' do
      message1 = FactoryBot.create(:message, to_number: '555')
      message2 = FactoryBot.create(:message, to_number: '555')
      message3 = FactoryBot.create(:message, to_number: '111')
      get '/message', params: { "to_number": '555' }
      res = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(res.any? { |m| m['id'] == message1.id }).to be true
      expect(res.any? { |m| m['id'] != message3.id }).to be true
    end

    it 'returns all messages of certain to_number' do
      message1 = FactoryBot.create(:message, provider_id: 1)
      message2 = FactoryBot.create(:message, provider_id: 1)
      message3 = FactoryBot.create(:message, provider_id: 2)
      get '/message', params: { "provider": "1" }
      res = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(res.any? { |m| m['id'] == message1.id }).to be true
      expect(res.any? { |m| m['id'] != message3.id }).to be true
    end
  end

  describe 'create' do
    it 'creates Message and returns message object' do
      post '/message', params: { "to_number": '555555555',
                                "message": 'test message' }
      res = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(res['to_number']).to eq('555555555')
    end

    it 'does not create Message if to_number is not a number' do
      post '/message', params: { "to_number": 'kjh',
                                "message": 'test message' }
      res = JSON.parse(response.body)
      expect(response.status).to eq 400
      expect(res['error']).to eq(['To number is not a number'])
    end

    it 'does not create Message if to_number is blank' do
      post '/message', params: { "to_number": '',
                                "message": 'test message' }
      res = JSON.parse(response.body)
      expect(response.status).to eq 400
      expect(res['error']).to eq(["To number can't be blank", 'To number is not a number'])
    end

    it 'does not create Message if message is blank' do
      post '/message', params: { "to_number": '555555555',
                                "message": '' }
      res = JSON.parse(response.body)
      expect(response.status).to eq 400
      expect(res['error']).to eq(["Message can't be blank"])
    end
  end

  describe 'update' do
    it 'updates a message status' do
      message = FactoryBot.create(:message)
      post '/update_message', params: { "message_id": message.message_id,
                                       "status": 'delivered' }
      message.reload
      expect(message.status).to eq('delivered')
    end
  end
end
