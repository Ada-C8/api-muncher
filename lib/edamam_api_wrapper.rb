require "httparty"
require "awesome_print"

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  EDAMAM_ID = ENV["EDAMAM_ID"]
  EDAMAM_KEY = ENV["EDAMAM_KEY"]

  def self.list_recipes(search_string, app_id = nil, app_key = nil)
    app_id ||= EDAMAM_ID
    app_key ||= EDAMAM_KEY

    url = BASE_URL + "q=" + search_string + "&app_id=#{app_id}" + "&app_key=#{app_key}"

    # ap url

    data = HTTParty.get(url)

    # ap data

    if data["hits"]
      my_recipes = data["hits"].map do |hit|
        Recipe.new(
          hit["recipe"]["uri"],
          hit["recipe"]["label"],
          hit["recipe"]["url"],
          hit["recipe"]["ingredientLines"],
          hit["recipe"]["dietLabels"],
          image: hit["recipe"]["image"],source: hit["recipe"]["source"])
      end
      return my_recipes
    else
      return []
    end
  end

  # def self.send_msg(channel, msg)
  #   ap "Sending #{msg} to channel #{channel}"
  #
  #   url = BASE_URL + "chat.postMessage?" + "token=#{TOKEN}"
  #
  #   response = HTTParty.post(url, body: {
  #     "text" => "#{msg}",
  #     "channel" => "#{channel}",
  #     "username" => "AdaBot",
  #     "icon_emoji" => ":cheezit:",
  #     "as_user" => "false"
  #     },
  #     headers: { 'Content-Type' => "application/x-www-form-urlencoded"}
  #   )
  #
  #   # return response.success?
  #   return response["ok"]
  #
  # end
end
