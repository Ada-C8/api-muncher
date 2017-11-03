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


#"https://api.edamam.com/search?q=chicken&app_id=${YOUR_APP_ID}&app_key=${YOUR_APP_KEY}&"
# https://api.edamam.com/search?r=http://www.edamam.com/ontologies/edamam.owl%23recipe_ac4795627030ca70b0795f96641350cb

  def self.list_recipes(search_term, end_url=END_URL)
    puts "Searching for #{search_term}"
    url = BASE_URL + "q=" + search_term + end_url + "&from=0&to=100&"
    puts url
    response = HTTParty.post(url)
    check_status(response.parsed_response)
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
  #  http://www.edamam.com/ontologies/edamam.owl#recipe_278eaf9aa539ccfac63dbe5faf56343f


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

  def self.check_status(response)
    puts response.count
    if response.count == 0
      raise ApiError.new("API call to slack failed")
    end
  end

end
