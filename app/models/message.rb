# Message Model
class Message < ApplicationRecord
  validates :message, :to_number, presence: true
  validates :to_number, numericality: true
  belongs_to :provider, optional: true
end
