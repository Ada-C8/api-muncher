class RecipesController < ApplicationController
  def home
  end

  def index
    if !is_word?(params[:ingredient])
      flash[:status] = :failure
      flash[:message] = "Not a word"
      return redirect_to root_path
    end

    @recipes = EdamamApiWrapper.list_recipes(params[:ingredient]).paginate page: params[:page], per_page: 10, previous_label: ">", next_label: "<"
    @count = EdamamApiWrapper.num_recipes(params[:ingredient])

    unless @recipes
      render file: '/public/404.html', status: 404
    end
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:uri])

    unless @recipe
      render file: '/public/404.html', status: 404
    end
  end

  private

  def is_word?(input)
    return false if !input

    # return input.strip.match(/^[a-zA-Z]+(\-||\s?)[a-zA-Z]+$/)
    return /^[a-zA-Z]+(\-||\s?)[a-zA-Z]+$/.match?(input.strip)
  end
end
