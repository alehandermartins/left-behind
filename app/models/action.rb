# frozen_string_literal: true

class Action < ApplicationRecord
  belongs_to :location
  belongs_to :game

  validates :cost, numericality: { greater_than: 0 }
  attribute :result, enum: %i[success failure]

  enum :status, %i[undone done]

  def success!
    self.done!
    self.result = :success
  end

  def failure!
    self.result = :failure
  end

  def dependencies?
    return false if self.dependencies.blank?

    Action.where(game: game, index: extract_dependencies, status: :undone).any?
  end

  def needs_hint?
    self.undone? || !self.necessary
  end

  private

  def extract_dependencies
    self.dependencies.to_i
  end
end
