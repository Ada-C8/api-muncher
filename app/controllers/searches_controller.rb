require_dependency '../../lib/Muncher_Api_Wrapper'
require_dependency '../../lib/recipe'

class SearchesController < ApplicationController
  def root

  end

  def index
    if params[:from]
      @from = params[:from].to_i
    else
      @from = 0
    end
    @recipes = MuncherApiWrapper.search(params[:search_term], @from)
  end


  def show
    @recipe = MuncherApiWrapper.show(params[:uri])
  end

end
