require 'pry'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["EDAMAN_ID"]
  APP_KEY = ENV["EDAMAN_KEY"]
  Q = "?q="
  R = "?r="

  class ApiError < StandardError
  end

  def self.list_recipes(search_term, key=APP_KEY)
    url = build_url(search_term, key)

    response = HTTParty.get(url)

    check_hits(response)
    recipies_array = []

    response["hits"].each do |hit_data|
      recipe_data = hit_data["recipe"]
      recipies_array << create_recipe(recipe_data)
    end

    return recipies_array
  end

  def self.show_recipe(uri, key=APP_KEY, type=R)
    uri = uri_regex(uri)
    url = build_url(uri, key, type)

    response = HTTParty.get(url)

    recipe = ''
    
    if response.empty?
      raise ApiError.new("Api call to Edaman to show a given failed.")
    else
      recipe = create_recipe(response[0])
    end

    return recipe
  end


private
  # make sure status is 200 okay, and you have at least one search results, otherwise raise ApiError
  def self.check_hits(response)
    unless response.code == 200
      raise ApiError.new("Api call to Edaman failed. Status was #{response.code} #{response.message}")
    else
      if response["count"] < 1
        raise ApiError.new("Api call to Edaman failed to return any results for the search term #{response["q"]}")
      end
    end
  end

  def self.create_recipe(api_params)
    return Recipe.new(
      api_params["label"],
      api_params["uri"],
      {
        image: api_params["image"],
        source: api_params["source"],
        url: api_params["url"],
        yield: api_params['yield'],
        calories: api_params['calories'],
        ingredientLines: api_params["ingredientLines"],
        healthLabels: api_params["healthLabels"],
        totalDaily: api_params['totalDaily'],
        dietLabels: api_params["dietLabels"]
      }
    )
  end

  def self.build_url(search_term, key, type=Q)
    return BASE_URL + type + search_term + "&app_id=" + APP_ID + "&app_key=" + key
  end

  def self.uri_regex(uri)
    return uri.sub(/[#]{1}/, '%')
  end
end
