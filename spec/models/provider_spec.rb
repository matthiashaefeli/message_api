require 'rails_helper'

RSpec.describe 'Provider', type: :model do
  describe 'providers_available' do
    it 'returns providers with count < load' do
      provider1 = FactoryBot.create(:provider, load: 10, count: 10)
      provider2 = FactoryBot.create(:provider, load: 10, count: 0)
      providers = Provider.providers_available([])
      providers.exclude?(provider1)
      providers.include?(provider2)
    end

    it 'returns no providers if count == load' do
      provider1 = FactoryBot.create(:provider, load: 10, count: 10)
      provider2 = FactoryBot.create(:provider, load: 10, count: 10)
      providers = Provider.providers_available([])
      providers.empty?
    end

    it 'does not return provider in array' do
      provider1 = FactoryBot.create(:provider)
      provider2 = FactoryBot.create(:provider)
      providers = Provider.providers_available([provider1.id])
      providers.exclude?(provider1)
    end
  end

  describe 'reset_providers' do
    it 'resets provider count to 0' do
      provider1 = FactoryBot.create(:provider, load: 10, count: 10)
      Provider.reset_providers
      provider1.reload
      expect(provider1.count).to eq 0
    end
  end

  describe 'ready_to_use' do
    it 'returns provider ready to use' do
      provider1 = FactoryBot.create(:provider)
      message_creator = MessageCreator.new('test message')
      provider = Provider.ready_to_use(message_creator)
      expect(provider).to eq provider1
    end

    it 'returns next provider if providers_down include provider' do
      provider1 = FactoryBot.create(:provider, count: 0)
      provider2 = FactoryBot.create(:provider, count: 0)
      message_creator = MessageCreator.new('test message')
      message_creator.providers_down.push(provider1.id)
      provider = Provider.ready_to_use(message_creator)
      expect(provider).to eq provider2
    end

    it 'returns nil if loop == true and provider_down == Provider.length' do
      provider1 = FactoryBot.create(:provider, count: 0)
      provider2 = FactoryBot.create(:provider, count: 0)
      message_creator = MessageCreator.new('test message')
      message_creator.providers_down.push(provider1.id)
      message_creator.providers_down.push(provider2.id)
      message_creator.loop = true
      provider = Provider.ready_to_use(message_creator)
      expect(provider).to eq nil
    end
  end

  it 'is valid with valid attributes' do
    expect(Provider.new(name: 'test',
                        url: 'url',
                        load: 10)).to be_valid
  end

  it 'is not valid without a name' do
    expect(Provider.new(url: 'url',
                        load: 10)).to_not be_valid
  end

  it 'is not valid without a url' do
    expect(Provider.new(name: 'test',
                        load: 10)).to_not be_valid
  end

  it 'is not valid without a load' do
    expect(Provider.new(name: 'test',
                        url: 'url')).to_not be_valid
  end

  it 'is not valid if load is not a number' do
    expect(Provider.new(name: 'test',
                        url: 'url',
                        load: 'string')).to_not be_valid
  end
end
