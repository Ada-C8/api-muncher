module Confirmation
  # NOTE: Both of these implementations of empty should return true if passed an empty sting ("") and nil (or false in the ones I changed to do that) if passed a sting with characters in it ("ddd")
  # Question: why do neither of these methods catch the error in the controller when the search term is an empty sting?
  # def empty(search_term)
  #   if search_term == ""
  #     return true
  #   end
  # end

  # def empty(search_term)
  #   if search_term.length < 1
  #     return true
  #   else
  #     return false
  #   end
  # end

# NOTE: Can make the other empty methods one line like this too :)
  def empty(search_term)
    return search_term.to_s.strip.empty?
  end

  def symbols(search_term)
    if !(search_term.match(/\A[[:alpha:][:blank:]]+\z/))
      return true
    end # if
  end
end # Confirmation
