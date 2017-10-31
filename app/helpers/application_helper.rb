module ApplicationHelper

  def format_uri(uri)
    index = uri.index('recipe_')+7
    return uri[index..-1]
  end

  def format_number(num)
    return num.round
  end
end
