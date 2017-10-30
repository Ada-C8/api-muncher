class EdamamApiWrapper

  BASE_URL = "https://api.edamam.com/search?"
  APP_ID = ENV["APP_ID"]
  APP_KEY = ENV["APP_KEY"]

  def self.query

  end
  url = BASE_URL + "q=#{query}&app_id=#{APP_ID}&app_key=#{APP_KEY}"
end
