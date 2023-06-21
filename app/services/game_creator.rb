# frozen_string_literal: true

class GameCreator

  ARCHETYPES = %w[starship island labyrinth]

  def initialize(user)
    @user = user
  end

  def create
    archetype = (ARCHETYPES - @user.played_archetypes).sample

    ActiveRecord::Base.transaction do
      game = Game.create!(archetype: archetype)
      Player.create!(user: @user, game: game)
      @user.update!(current_game: game)

      file = YAML.safe_load(Rails.root.join("config/locales/#{archetype}/en.yml").read)
      file['en'][archetype]['locations'].each do |index, values|
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
