module ApplicationHelper

  def print_results(results_array)
    if results_array.count < 1
      return "None"
    else
      return results_array.join(", ")
    end 
  end

end
