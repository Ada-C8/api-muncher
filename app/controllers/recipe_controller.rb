class RecipeController < ApplicationController

def root

end

  def index
    @recipies = EdemamApiWrapper.list_recipes
  end
end
