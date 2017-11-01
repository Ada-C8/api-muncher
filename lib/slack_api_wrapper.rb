require 'httparty'

class SlackApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  TOKEN = ENV["SLACK_TOKEN"]

  def self.recipe_query(query)
    url = BASE_URL + "search?q=#{query}"
    data = HTTParty.get(url)
    if data["channels"]
      return data["channels"]
    else
      return []
    end
  end

  def self.recipe_details(url)

  url = BASE_URL + "search?" + "r=#{url}"
  response = HTTParty.get(url,
  body:  {
    "text" => "#{msg}",
    "channel" => "#{channel}",
    "username" => "Roberts-Robit",
    "icon_emoji" => ":robot_face:",
    "as_user" => "false"
  },
  :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' })
  return response.success?
end
end
