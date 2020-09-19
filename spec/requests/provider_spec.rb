require 'rails_helper'

RSpec.describe 'Provider', type: :request do
  it 'creates a Provider and returns provider object' do
    post '/provider', params: { provider: { "name": 'provider',
                                            "url": 'https://provider',
                                            "load": '10' } }
    res = JSON.parse(response.body)
    expect(response.status).to eq 200
    expect(res['name']).to eq('provider')
  end

  it 'does not create Provider with a blank name' do
    post '/provider', params: { provider: { "name": '',
                                            "url": 'https://provider',
                                            "load": '10' } }
    res = JSON.parse(response.body)
    expect(response.status).to eq 400
    expect(res['error']).to eq(["Name can't be blank"])
  end

  it 'does not create Provider with a blank url' do
    post '/provider', params: { provider: { "name": 'provider',
                                            "url": '',
                                            "load": '10' } }
    res = JSON.parse(response.body)
    expect(response.status).to eq 400
    expect(res['error']).to eq(["Url can't be blank"])
  end

  it 'does not create Provider if load is not a number' do
    post '/provider', params: { provider: { "name": 'provider',
                                            "url": 'https://provider',
                                            "load": 'a' } }
    res = JSON.parse(response.body)
    expect(response.status).to eq 400
    expect(res['error']).to eq(['Load is not a number'])
  end

  it 'returns all providers' do
    provider = FactoryBot.create(:provider)
    get '/provider'
    res = JSON.parse(response.body)
    expect(response.status).to eq 200
    expect(res.any? { |p| p['id'] == provider.id }).to be true
  end

  it 'updates provider active' do
    provider = FactoryBot.create(:provider)
    post '/update_provider', params: { provider: { "id": provider.id,
                                                   "active": false } }
    provider.reload
    expect(provider.active).to be false
  end

  it 'updates provider load' do
    provider = FactoryBot.create(:provider)
    post '/update_provider', params: { provider: { "id": provider.id,
                                                   "load": 30 } }
    provider.reload
    expect(provider.load).to eq(30)
  end
end
