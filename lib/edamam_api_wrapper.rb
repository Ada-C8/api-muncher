class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?q="
  ID_AND_KEY = "&app_id=#{ENV["EDAMAM_ID"]}&app_key=#{ENV["EDAMAM_KEY"]}"

  def self.search(query)
    url = BASE_URL + query + ID_AND_KEY
    data = HTTParty.get(url)
    unless data["hits"].empty?
      return data["hits"]
      # data["hits"][0]["recipe"]["label"]
    else
      return []
    end
  end


end
