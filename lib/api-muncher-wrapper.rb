require 'httparty'

class ApiMuncherWrapper
  # Your code here!
  BASE_URL = "https://api.edamam.com/search"
  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]

  # def self.list_channels
  #   url = BASE_URL + "channels.list?token=#{TOKEN}&exclude_archived=1"
  #   data = HTTParty.get(url)
  #   if data["channels"]
  #     my_channels = data["channels"].map do |channel_hash|
  #       Channel.new(channel_hash["name"], channel_hash["id"],
  #       purpose: channel_hash["purpose"],
  #       is_archived: channel_hash["is_archived"],
  #       is_general: channel_hash["is_general"],
  #       members: channel_hash["members"])
  #     end
  #     return my_channels
  #   else
  #     return []
  #   end
  # end
  #
  # def self.send_msg(channel, msg)
  #   p "Sending #{msg} to channel: #{channel}"
  #
  #   url = BASE_URL + "chat.postMessage?token=#{TOKEN}"
  #
  #   response = HTTParty.post(url,
  #   body: {"text"=> "#{msg}", "channel"=>"#{channel}",
  #   "username"=> "KHALEESI", "icon_emoji"=>":khaleesi:",
  #   "as_user" => "false"},
  #   :headers => { 'Content-Type' => 'application/x-www-form-urlencoded'})
  #
  #   return response.success?
  # end

end
