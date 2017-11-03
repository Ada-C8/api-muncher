require 'HTTParty'

class MuncherApiWrapper
  BASE_URL = "https://test-es.edamam.com/search"
  ID = ENV["EDAMAN_ID"]
  KEY = ENV["EDAMAN_KEY"]

  def self.find_recipes(word, page)
    url = BASE_URL + "?q=" + word + "&app_id=#{ID}" + "&app_key=#{KEY}"+"&from=#{((page.to_i)*10)-10}&to=#{page.to_i*10}"
    data = HTTParty.get(url)
    recipe_list = []
    if data["hits"]
      data["hits"].each do |recipe_array|
        recipe_list << create_recipe(recipe_array["recipe"])
      end
    end
    return recipe_list
  end

  def self.one_recipe(id)
    url = BASE_URL + "?r=http://www.edamam.com/ontologies/edamam.owl%23recipe_" + id + "&app_id=#{ID}" + "&app_key=#{KEY}"
    data = HTTParty.get(url)

    puts "Got response from Edamam with status #{data.code}: #{data.message}"
    puts "Parsed response: #{data.parsed_response}"

    # if data
    #   create_recipe(data[0])
    # else
    #   return nil
    # end

    begin
      return nil if data.empty?
    rescue
      return nil
    end

    create_recipe(data[0])
  end



  # def self.find(id)
  #     url = BASE_URL + AUTH_URL +  "&r=" + FIND_URL + id
  #     response = HTTParty.get(url)
  #
  #     begin
  #       return nil if response.empty?
  #     rescue
  #       return nil
  #     end
  #
  #     new_recipe(response[0])
  #   end
  #
  #
  #   BASE_URL = 'https://api.edamam.com/search?'
  #     AUTH_URL = "app_id=#{ID}&app_key=#{KEY}"
  #     FIND_URL = "http://www.edamam.com/ontologies/edamam.owl%23recipe_"
  #
  #
  #












  private
  def self.create_recipe(api_params)
    return Recipe.new(
    # api_params["recipe"]["id"],
    # api_params["recipe"]["uri"],
    # api_params["recipe"]["label"],
    # api_params["recipe"]["image"],
    # api_params["recipe"]["url"],
    # api_params["recipe"]["ingridientLines"]
    api_params["uri"][-32..-1],
    api_params["label"],
    api_params["image"],
    api_params["url"],
    api_params["ingridientLines"]
    #TODO poner algo de dietary information api_params["recipe"]["uri"],
    )
  end
end
