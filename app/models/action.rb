# frozen_string_literal: true

class Action < ApplicationRecord
  belongs_to :location

  validates :cost, numericality: { greater_than: 0 }

  enum :status, %i[undone done]
end
