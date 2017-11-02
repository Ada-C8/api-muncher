require "test_helper"

describe Favorite do
  let(:favorite) { Favorite.new }

  it "must be valid" do
    fav = Favorite.new(user: users(:kayla), uri: '12312nskdfsdf', label: "pumpkin", source:'me')
    fav.valid?.must_equal true
    proc{fav.save}.must_change 'Favorite.count', 1

  end

  it "must have an user id" do
    fav = Favorite.new( uri: '12312nskdfsdf', label: "pumpkin", source:'me')
    fav.valid?.must_equal false

    fav = Favorite.new(user: users(:kayla), label: "pumpkin", source:'me')
    fav.valid?.must_equal false
  end
end
