require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recette'

class RecettesController < ApplicationController
  def index

    diet_labels = [params["balanced"], params["high-protein"], params["low-fat"], params["low-carb"]
  ]

    health_labels = [
      params["vegan"], params["vegetarian"], params["low-sugar"], params["peanut-free"], params["tree-nut-free"], params["alcohol-free"]
    ]


    if params["item"]
      add_labels = ""
      search = params["item"] + " "
      if diet_labels != []
        diet_labels.each do |label|
          unless label == nil
            add_labels += "&diet=#{label}"
            search += "+ #{label} "
          end
        end
      end
      if health_labels != []
        health_labels.each do |label|
          unless label == nil
            add_labels += "&health=#{label}"
            search += "+ #{label} "
          end
        end
      end
      search = search.titleize.strip
    end



    non_paginated_recipes = EdamamApiWrapper.list_recipes(params["item"], add_labels)

    if session[:user_id] && search.present?
      user = User.find_by_id(session[:user_id])
      user.recent_search << search unless user.recent_search.include? search
      user.save
    end


    if non_paginated_recipes
      non_paginated_recipes == false
    else
      if session[:user_id]
        user = User.find_by_id(session[:user_id])
        user.recent_search << search unless user.recent_search.include? search
        user.save
      end
    end

    @recipes = non_paginated_recipes.paginate(:page => params[:page], per_page: 9)

    render :index
  end

  def show

    @recipe = EdamamApiWrapper.find_recipe(params["uri"])
    if @recipe == false
      flash[:status] = :failure
      flash[:message] = "Could not find recipe"
      return redirect_to root_path
    end
  end
end
