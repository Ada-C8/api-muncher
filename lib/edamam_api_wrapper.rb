require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  SEARCH_URL = "q="
  SHOW_URL = "r="
  CRED_URL = "&app_id=#{ENV["APP_ID"]}&app_key=#{ENV["APP_KEY"]}"

  def self.search_recipes(search)
    url = BASE_URL + SEARCH_URL + "#{search}" + CRED_URL
    response = HTTParty.get(url)
    recipes = []
    if response["hits"]
      response["hits"].each do |recipe_data|
        recipes << create_recipe(recipe_data)
      end
    else
      return []
    end
    return recipes
  end

  # def self.show_recipe(id)
  #   url =
  #
  # end


  # def self.list_channels
  # url = BASE_URL + "channels.list?" + "token=#{TOKEN}" + "&exclude_archived=1"
  # data = HTTParty.get(url)
  # channel_list = []
  # if data["channels"]
  #   data["channels"].each do |channel_data|
  #     channel_list << create_channel(channel_data)
  #   end
  # else
  #   return []
  # end
  # return channel_list
  # end
  #
  # def self.send_msg(channel, msg)
  #   puts "Sending message to channel #{channel}: #{msg}"
  #
  #   url = BASE_URL + "chat.postMessage?" + "token=#{TOKEN}"
  #   response = HTTParty.post(url,
  #   body:  {
  #     "text" => "#{msg}",
  #     "channel" => "#{channel}",
  #     "username" => "Roberts-Robit",
  #     "icon_emoji" => ":robot_face:",
  #     "as_user" => "false"
  #   },
  #   :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' })
  #   return response.success?
  # end
  #

  private

  # def self.create_channel(api_params)
  #     return Channel.new(
  #       api_params["name"],
  #       api_params["id"],
  #       {
  #         purpose: api_params["purpose"],
  #         is_archived: api_params["is_archived"],
  #         members: api_params["members"]
  #       }
  #     )
  # end

  def self.create_recipe(api_params)
    return Recipe.new(
      api_params["recipe"]["label"],
      api_params["recipe"]["url"],
      api_params["recipe"]["image"],
      api_params["recipe"]["ingredientLines"],
      api_params["recipe"]["healthLabels"]
    )
  end
end
