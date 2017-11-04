Rails.application.routes.draw do

  scope "(:locale)", :locale => /en|es/ do

    root 'recipes#home'

    get 'recipes/:name', to: 'recipes#show', as: 'recipe'

    get 'recipes/', to: 'recipes#index', as: 'recipes'
  end

  get '/:lang', to: 'recipes#home', as: 'lang_home'

  get '/:lang/recipes/:name', to: 'recipes#show', as: 'lang_recipe'

  get '/:lang/recipes/', to: 'recipes#index', as: 'lang_recipes'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
