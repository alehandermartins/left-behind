# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :game
  has_many :actions
end
