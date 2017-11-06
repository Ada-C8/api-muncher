require 'base64'

class ApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  API_ID = ENV["APPLICATION_ID"]
  TOKEN = ENV["EDAMAM_API_TOKEN"]

  #making custom error
  class ApiError < StandardError
  end

  def self.list_recipes(search)
    url = BASE_URL +  "?q=#{search}&app_id=#{API_ID}&app_key=#{TOKEN}" + "&from=0" + "&to=150"

    data = HTTParty.get(url)

    check_status(data)

    # need array to store the parsed api hash results
    recipes_list = []

    if data["hits"]
      # data["hits"] is an array of hashes, within each hash there are sub-hashes and sub-arrays, we need
      data["hits"].each do |recipe_info_hash|
        recipes_list << self.create_recipe(recipe_info_hash["recipe"])
      end
    end
    return recipes_list
  end

  def self.find_recipe(uri)

    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    puts uri

    # make a url to call on the edamam api
    recipe_link = BASE_URL + "?r=#{uri}&app_id=#{API_ID}&app_key=#{TOKEN}"
    puts "this is the recipe link #{recipe_link}"
puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
puts "this is the uri #{uri}"
    # https://api.edamam.com/search
    # https://api.edamam.com/search?q=chicken&app_id=${YOUR_APP_ID}&app_key=${YOUR_APP_KEY}&from=0&to=3&calories=gte%20591,%20lte%20722&health=alcohol-free

    data = HTTParty.get(recipe_link)




    # parse the JSON data in order to get recipe details for the show page
    if data.empty?
      raise ApiError.new("No recipe details for this link")
    else
      recipe_detail = self.create_recipe(data[0])
    end
    return recipe_detail
  end

  private

  def self.check_status(response)
    unless response.ok?
      raise ApiError.new("API call to Edamam failed")
    end
  end


  def self.create_recipe(recipe_hash)
    recipe = Recipe.new(

      # gets the name of the recipe
      recipe_hash["label"],
      recipe_hash["url"],
      recipe_hash["ingredientLines"],
      recipe_hash["dietLabels"],
      recipe_hash["uri"],
      recipe_hash["source"],
      {
        image: recipe_hash["image"],
      }
    )
    return recipe
  end

end
