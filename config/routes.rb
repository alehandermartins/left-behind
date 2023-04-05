# frozen_string_literal: true

Rails.application.routes.draw do
  root 'games#index'

  resources 'games', only: %i[index create show]
  resources 'locations', only: [:index]
  resources 'moves', only: [:create]
  resources 'actions', only: [:index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
