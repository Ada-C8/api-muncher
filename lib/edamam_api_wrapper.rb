require "httparty"
# require "pry"

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  class ApiError < StandardError
  end

  def self.search_recipes(query)
    url = BASE_URL + "q=#{query}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}&from=0&to=200"

    response = HTTParty.get(url)

    return response.parsed_response
  end

  def self.show_recipe(uri)
    request = "http://www.edamam.com/ontologies/edamam.owl%23"

    url = BASE_URL + "r=#{request}#{uri}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"
    response = HTTParty.get(url)

    if response.parsed_response == []
      raise ApiError.new("Recipe does not exist")
    end

    return EdamamApiWrapper.create_recipe(uri, response)
  end

  private

  def self.create_recipe(uri, response)
    return Recipe.new(
      uri,
      {
        label: response[0]['label'],
        image: response[0]['image'],
        source: response[0]['source'],
        url: response[0]['url'],
        yield: response[0]['yield'],
        calories: response[0]['calories'],
        totalWeight: response[0]['totalWeight'],
        ingredients: response[0]['ingredients'],
        totalNutrients: response[0]['totalNutrients'],
        totalDaily: response[0]['totalDaily'],
        dietLabels: response[0]['dietLabels'],
        healthLabels: response[0]['healthLabels']
      }
    )
  end
end
