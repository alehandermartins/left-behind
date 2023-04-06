# frozen_string_literal: true

class GameCreator
  def initialize(user)
    @user = user
  end

  def create
    ActiveRecord::Base.transaction do
      game = Game.create!(archetype: 'starship', status: :ongoing)
      UserGame.create!(user: @user, game:)

      4.times do |n|
        Location.create!(game:, index: n)
      end

      locations = Location.all
      [1, 1, 2, 1, 2, 3, 1, 3, 2, 1, 3, 2].each_with_index do |cost, index|
        GameAction.create!(location: locations[index / 3], cost:, index:)
      end

      Item.create!(game:, user: @user, name: 'oxygen', quantity: 10)
      game
    end
  end
end
