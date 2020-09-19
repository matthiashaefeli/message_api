class Provider < ApplicationRecord
  validates :name, :url, :load, presence: :true
  validates :load, :numericality => true

  def self.ready_to_use(message_creator)
    if message_creator.loop && message_creator.providers_down.length == Provider.count
      return nil
    end

    if self.providers_available(message_creator.providers_down).empty?
      self.reset_providers
      message_creator.reset_providers_down
    end

    self.providers_available(message_creator.providers_down).first
  end

  def self.reset_providers
    self.update_all(count: 0)
  end

  def self.providers_available(ids_array)
    self.where.not(id: ids_array).where('count < load and active = true')
  end
end
