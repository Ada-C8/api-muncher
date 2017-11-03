require 'httparty'

class EdamamApiWrapper
  # Your code here!

  # set the base_url, key, and ID equal to contant variables to simplify url variable in the list_recipes method.
  BASE_URL = "https://api.edamam.com/search"
  KEY = ENV["EDAMAM_KEY"]
  ID = ENV["Application_ID"]

  # (search) takes in the params from the form on the homepage. The index controller method takes this: (params[:search]). the method below doesnt know what that is however because it is passed as the parameter, it can work with the value of what is passed.
  def self.list_recipes(search)
    url = BASE_URL + "?q=" + search + "&app_id=" + ID + "&app_key=" + KEY + "&from=0&to=200"

    data = HTTParty.get(url)

    # instantiating a new recipe for every hit hash in the data hash.
    # hits is an array and each index is a hash. recipe is the key and value is another hash.

    if data["hits"]
      my_hits = data["hits"].map do |hit_hash|
        Recipe.new hit_hash["recipe"]["label"], hit_hash["recipe"]["dietLabels"], hit_hash["recipe"]["image"], hit_hash["recipe"]["url"], hit_hash["recipe"]["source"], hit_hash["recipe"]["ingredients"], hit_hash["recipe"]["uri"]
      end
      return my_hits
    else
      return []
    end
  end




  def self.show_recipe(search)
    # MUST ENCODE THE SEARCH PARAMETER IN THE URL
    url = BASE_URL + "?r=" + (URI.encode(search))

    data = HTTParty.get(url)

    Recipe.new data[0]["label"], data[0]["dietLabels"], data[0]["image"], data[0]["url"], data[0]["source"],data[0]["ingredients"], data[0]["uri"]

  end
end
