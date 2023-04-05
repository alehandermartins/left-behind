# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validates :name, presence: true
  validates :quantity, presence: true

  scope :oxygen, -> { where(name: 'oxygen') }
end
