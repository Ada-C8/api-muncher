module ApplicationHelper
  def display_array_attributes(array)
    html = ""
    array.each do |item|
      html += "<p>#{item}</p>"
    end
    return html.html_safe
  end
end
