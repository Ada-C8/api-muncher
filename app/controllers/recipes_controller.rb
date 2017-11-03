class RecipesController < ApplicationController
  before_action :is_spanish # in App Controller

  def home
  end

  def index
    if !is_word?(params[:ingredient])
      flash[:status] = :failure
      flash[:message] = @spanish ? "No es una palabra" : "Not a word"
      return redirect_to root_path
    end

    @recipes = EdamamApiWrapper.list_recipes(params[:ingredient], spanish: @spanish).paginate page: params[:page], per_page: 10
    @count = EdamamApiWrapper.num_recipes(params[:ingredient], spanish: @spanish)

    unless @recipes
      render file: '/public/404.html', status: 404
    end
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:uri], spanish: @spanish)

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

  # def is_spanish
  #   @spanish = params[:lang] == "es" ? true : false
  # end
end
