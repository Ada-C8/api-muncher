module Confirmation
  def self.empty_search_term(search_term)
    if search_term == ""
      raise BlankSearchError.new("You entered a blank search term .... let's try that agine)")
    end
  end

  def self.contain_symbols(search_term)
    if !(search_term.match(/\A[[:alpha:][:blank:]]+\z/))
      raise BadSearchTermError.new("Sorry, your search term cannot contain numbers or symbols: #{search_term}")
    end # if
  end
end # Confirmation
