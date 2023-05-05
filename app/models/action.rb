# frozen_string_literal: true

class Action < ApplicationRecord
  belongs_to :location

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

    Action.where(index: extract_dependencies, status: :undone).any?
  end

  private

  def extract_dependencies
    self.dependencies.to_i
  end
end
