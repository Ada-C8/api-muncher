#require "httparty"
#require 'pry'

class EdemamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["APP_ID"]
  APP_KEY= ENV["APP_KEY"]
  END_URL = "&app_id=" + APP_ID + "&app_key=" + APP_KEY
  URI_BASE ="http://www.edamam.com/ontologies/edamam.owl%23recipe_"

  class ApiError < StandardError
  end

  def self.list_recipes(search_term, end_url=END_URL)
    url = BASE_URL + "q=" + search_term + end_url + "&from=0&to=100&"
    response = HTTParty.post(url)
    #check_status(response.parsed_response["hits"])
    hits = response.parsed_response["hits"]
    recipe_list = []
    if hits
      hits.each do |hit|
        recipe_list << create_recipe(hit["recipe"])
      end
    end
    return recipe_list
  end

  def self.find_a_recipe(uri)
    url = BASE_URL + "r=" + URI_BASE + uri + END_URL
    response = HTTParty.get(url).parsed_response
    check_status(response)
    return create_recipe(response[0])
  end


  private

  def self.create_recipe(api_params)
    label = api_params["label"]
    recipe_url = api_params["url"]
    ingredients = api_params["ingredientLines"]
    dietary = api_params["healthLabels"]
    image = api_params["image"]
    source = api_params["source"]
    uri = api_params["uri"]
    return Recipe.new(label, recipe_url, ingredients, dietary, image, source, uri)
  end

  def self.check_status(hits)
    if hits == []
      raise ApiError.new("API call to slack failed")
    end
  end

end
