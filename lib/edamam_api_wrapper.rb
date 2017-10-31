class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]
#https://api.edamam.com/search?q=chicken&app_id=d2fbdaf7&app_key=6e7b5b6faead1b3deffb7fe4416542c2

  def self.search(q)
    url = BASE_URL + "?q=#{q}" + "&app_id=#{APP_ID}" + "&app_key=#{APP_KEY}"

    response = HTTParty.get(url)
    return response
  end
end

# Wrap HTTP Party in a class and then call it in the controller
