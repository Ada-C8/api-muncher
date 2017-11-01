Rails.application.routes.draw do

  root 'recipes#root'

  get '/logout', to: "users#logout"

  get "/auth/:provider/callback", to: "users#create"

  get '/users/:id', to: 'users#show', as: 'user'

  post '/recipes/:uri', to: 'user#favorite', as: 'favorite'

  get '/recipes/:uri', to: 'recipes#show', as: 'recipe'

  get '/recipes/', to: 'recipes#index', as: 'recipes'

end
