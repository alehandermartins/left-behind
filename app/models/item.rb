# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :name, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :quantity_not_below_zero

  scope :oxygen, -> { where(name: 'oxygen') }

  def quantity_not_below_zero
    self.quantity = 0 if quantity.negative?
  end
end
