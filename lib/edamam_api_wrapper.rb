# lib/edamam_api_wrapper.rb
require `httparty`

class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search"
  KEY = ENV["EDAMAM_KEY"]
  ID = ENV["Edamam_App_ID"]

  # Method to list recipes.

  def self.list_recipes()
    url = BASE_URL + "" + "key=#{KEY}" + ""
    data = HTTParty.get(url)
    if data["recipes"]
      return data["recipes"]
    else
      return []
    end
  end
  
  # Method to show recipes.

  def self.show_recipe()
    url = BASE_URL + ""
    data = HTTParty.get(url)

    Recipe.new data
  end
end
