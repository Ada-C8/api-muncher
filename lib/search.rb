class Search
  attr_reader :query, :hits, :page

  def initialize(response)
    @query = response['q']
    @hits = response['hits']
    @page = 1
  end


end
