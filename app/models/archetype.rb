# frozen_string_literal: true

class Archetype < ApplicationRecord
  has_many :games
  has_many :locations
end
