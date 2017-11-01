require "HTTParty"
require "pry"

class EdamamApiMuncher
  BASE_URL = "https://api.edamam.com/search?q="
  APP_ID = ENV["API_ID"]
  API_KEY = ENV["API_KEY"]


# q=chicken&app_id=3959fd1f&app_key=d4f2a5e71269a4e586e6b5bf09346f8a
  def self.search_resipes(food)
    url = BASE_URL + food + "&app_id=#{APP_ID}" + "&app_key=#{API_KEY}"
    data = HTTParty.get(url)
     = []
    if data["channels"]
      data["channels"].each do |channel_data|
        channel_list << create_channel(channel_data)
      end
    end
    return channel_list
  end

  def self.send_msg(channel, msg)
    puts "Sending message to channel #{channel}: #{msg}"

    url = BASE_URL + "chat.postMessage?" + "token=#{TOKEN}"
    response = HTTParty.post(url,
    body:  {
      "text" => "#{msg}",
      "channel" => "#{channel}",
      "username" => "Roberts-Robit",
      "icon_emoji" => ":rocket:",
      "as_user" => "false"
    },
    :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' })
    return response.success?
  end


  private

  def self.create_channel(api_params)
      return Channel.new(
        api_params["name"],
        api_params["id"],
        {
          purpose: api_params["purpose"],
          is_archived: api_params["is_archived"],
          members: api_params["members"]
        }
      )
    end

end
