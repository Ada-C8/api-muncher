class RecipesController < ApplicationController
  def index
    if params[:search]
      return @recipes = EdamamApiWrapper.list_recipes(search_string)
    else
      return nil
    end
  end

  def search

  end

  # def create
  #   result = SlackApiWrapper.send_msg(params["channel"], params["message"])
  #
  #   if result
  #     flash[:success] = "Message Posted!"
  #   else
  #     flash[:error] = "Error!"
  #   end
  #
  #   # redirect_to root_path
  #
  #   # message = params["message"]
  #   # channel = params["channel"]
  #   # response = SlackApiWrapper.send_msg(channel, message)
  #   #
  #   # if response
  #   #   flash[:success] = "Message Posted!"
  #   # else
  #   #   flash[:error] = "Error!"
  #   # end
  #
  #   redirect_to chat_new_path(params["channel"])
  # end
end
