require 'rails_helper'

RSpec.describe 'Message', type: :model do
  it 'is valid with valid attributes' do
    expect(Message.new(message: 'test',
                       to_number: '555')).to be_valid
  end

  it 'is not valid without message' do
    expect(Message.new(to_number: '555')).not_to be_valid
  end

  it 'is not valid without to number' do
    expect(Message.new(message: 'test')).not_to be_valid
  end

  it 'is not valid if to_number is not a number' do
    expect(Message.new(message: 'test',
                       to_number: 'a')).not_to be_valid
  end
end