class RecipeController < ApplicationController
  def index
    response = EdamamWrapper.search(params[:q])

    response.hits.map do |result|
      result[:recipe][:label]
      result[:]
    end
  end

  def show

  end
end
