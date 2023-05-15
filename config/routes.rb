# frozen_string_literal: true

Rails.application.routes.draw do
  root 'sessions#new'

  resources 'sessions', only: [:new]
  post 'provider', to: "sessions#redirect_to_provider", as: "session_provider"
  get "session", to: "sessions#create"

  resources 'games', only: %i[create show update]
  resources 'locations', only: %i[index show]
  resources 'actions', only: [:update]
end
