# frozen_string_literal: true

class GameCreator
  def initialize(user)
    @user = user
  end

  def create
    ActiveRecord::Base.transaction do
      game = Game.create!(archetype: 'starship')
      Player.create!(user: @user, game: game)
      @user.update!(current_game: game)

      archetype = YAML.safe_load(Rails.root.join('lib/archetypes/starship.yml').read)

      archetype['locations'].each do |index, values|
        location = Location.create!(game: game, index: index)

        values['actions'].each do |a_index, action|
          Action.create!(
            game: game,
            location: location,
            cost: action['cost'],
            necessary: action['necessary'],
            index: a_index,
            dependencies: action['dependencies']
          )
        end
      end

      game
    end
  end
end
