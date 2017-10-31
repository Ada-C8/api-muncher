

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?q="
  ID = ENV["EDAMAM_ID"]
  KEY = ENV["EDAMAM_KEY"]

  class ApiError < StandardError
  end

  class NoResultsError < StandardError
  end

  def self.get_recipies(search_term, key=KEY)
    # define the request url
    url = BASE_URL + search_term + "&app_id=" + ID + "&app_key=" + key

    # send the request to the Edamam API
    response = HTTParty.get(url)

    # Create an empty array to hold the instances of Recipe created
    recipies_returned = []

    if response.code == 200
      # if there are search results than create an instance of recipe for each "hit"
      if response["count"] > 0
        response["hits"].each do |recipe_data|
          recipies_returned << create_recipe(recipe_data)
        end # .each
      else
        raise NoResultsError.new("Sorry, no recipies match that serch term.")
      end # if/else ["count"]
    else
      raise ApiError.new("Call to Edamam API failed. Status was #{response.code} #{response.message}")
    end # if ["hits"]
    return recipies_returned
  end # get_recipies

private

def self.create_recipe(api_hits)
  return Recipe.new(
  api_hits["recipe"]["label"],
  api_hits["recipe"]["uri"],
  {
    photo: api_hits["recipe"]["image"],
    url: api_hits["recipe"]["url"],
    ingredients: api_hits["recipe"]["ingredients"],
    diet_labels: api_hits["recipe"]["dietLabels"]
  }
  )
end # self.create_recipe
end # class
