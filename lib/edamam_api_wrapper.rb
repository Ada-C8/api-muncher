require "httparty"

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  EDAMAM_ID = ENV["EDAMAM_ID"]
  EDAMAM_KEY = ENV["EDAMAM_KEY"]

  def self.list_recipes(app_id = nil, app_key = nil, search_string)
    app_id ||= EDAMAM_ID
    app_key ||= EDAMAM_KEY

    url = BASE_URL + "?q=" + search_string + "&app_id=$#{app_id}" + "&app_key=$#{app_key }"

    data = HTTParty.get(url)

    if data["channels"]
      my_channels = data["channels"].map do |channel_hash|
        Channel.new channel_hash["name"],
        channel_hash["id"], purpose:
        channel_hash["purpose"], is_archived:
        channel_hash["is_archived"], is_general:
        channel_hash["is_general"], members:
        channel_hash["members"]
      end
      # return data["channels"]
      return my_channels
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
