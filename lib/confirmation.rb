module Confirmation
  def empty(search_term)
    if search_term == ""
      return true
    end
  end

  def symbols(search_term)
    if !(search_term.match(/\A[[:alpha:][:blank:]]+\z/))
      return true
    end # if
  end
end # Confirmation
