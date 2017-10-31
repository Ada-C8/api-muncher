class Search
  attr_reader :query, :hits

  def initialize(response)
    @query = response['q']
    @hits = response['hits']

    return self
  end


end
