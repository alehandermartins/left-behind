# frozen_string_literal: true

class ChangeGameActionName < ActiveRecord::Migration[7.0]
  def change
    rename_table :game_actions, :actions
  end
end
