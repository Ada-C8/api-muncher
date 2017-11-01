Rails.application.routes.draw do
  get ':q/new', to: 'q#new', as: 'search_new'
end
