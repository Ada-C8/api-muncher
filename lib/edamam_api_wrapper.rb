require 'HTTParty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  SHOW_URL = "http://www.edamam.com/ontologies/edamam.owl%23"
  APP_ID = ENV["app_id"]
  APP_KEY = ENV["app_key"]

  def self.search(query)
    #needs to be encoded
    encoded_query = URI.encode("#{query}")
    url = BASE_URL + "?" + "app_id=#{APP_ID}" + "&" + "app_key=#{APP_KEY}" + "&" + "q=" + encoded_query
    # encoded_url = URI.encode("#{url}")
    data = HTTParty.get(url)
    if data["hits"]
      search_results = data["hits"].map do |recipe_hash|
        Recipe.new(
          recipe_hash["recipe"]["label"],
          recipe_hash["recipe"]["image"],
          uri: recipe_hash["recipe"]["uri"],
          url: recipe_hash["recipe"]["url"],
          ingredients: recipe_hash["recipe"]["ingredientLines"],
          nutrition: recipe_hash["recipe"]["digest"]
        )
      end
      return search_results
    else
      return []
    end
  end

  def self.view_recipe(uri)
    #get the show page
    #if search is a get request for a list of items,
    #show is a get request for an individual item, utilizing where uri acts
    #as an identifier

    url = BASE_URL + "?" + "app_id=#{APP_ID}" + "&" + "app_key=#{APP_KEY}" + "&" + "r=" + uri
    new_url = url.sub("#", "%23")

    data = HTTParty.get(new_url)
    # return data
    if data
      view_results = data.map do |recipe|
        Recipe.new(
          recipe["label"],
          recipe["image"],
          uri: recipe["uri"],
          url: recipe["url"],
          ingredients: recipe["ingredientLines"],
          nutrition: recipe["digest"]
        )
      end
      return view_results
    else
      return []
    end

  end

end
