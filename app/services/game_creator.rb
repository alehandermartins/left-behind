# frozen_string_literal: true

class GameCreator
  def initialize(user)
    @user = user
  end

  def create
    ActiveRecord::Base.transaction do
      game = Game.create!(archetype: 'starship', status: :ongoing)
      UserGame.create!(user: @user, game: game)
      @user.update!(current_game: game)

      archetype = YAML.safe_load(Rails.root.join("lib/archetypes/starship.yml").read)

      archetype["locations"].each do |index, values|
        location = Location.create!(game: game, index: index)

        values["actions"].each do |a_index, action|
          Action.create!(location: location, cost: action["cost"], necessary: action["necessary"], index: a_index)
        end
      end

      Item.create!(game: game, user: @user, name: 'oxygen', quantity: 10)
      game
    end
  end

  def locations
    {
      0 => {
        0 => {
          cost: 2,
          necessary: false
        },
        1 => {
          cost: 3,
          necessary: true
        },
        2 => {
          cost: 2,
          necessary: false
        },
      },
      1 => {
        3 => {
          cost: 1,
          necessary: true
        },
        4 => {
          cost: 2,
          necessary: false
        },
        5 => {
          cost: 3,
          necessary: false
        },
      },
      2 => {
        6 => {
          cost: 3,
          necessary: false
        },
        7 => {
          cost: 1,
          necessary: false
        },
        8 => {
          cost: 2,
          necessary: false
        },
      },
      3 => {
        9 => {
          cost: 2,
          necessary: true
        },
        10 => {
          cost: 1,
          necessary: false
        },
        11 => {
          cost: 3,
          necessary: false
        },
      }
    }
  end
end
