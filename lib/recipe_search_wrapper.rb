class RecipeSearchWrapper
  ID = ENV["ID"]
  KEY = ENV["KEY"]
  BASE_URL = "https://api.edamam.com/search"
  BUILD_URL = BASE_URL + "?app_id=#{ID}&app_key=#{KEY}"

  
end
