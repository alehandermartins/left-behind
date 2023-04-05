# frozen_string_literal: true

class UserGame < ApplicationRecord
  belongs_to :game
  belongs_to :user
end
