require "test_helper"

describe MuncherApi do
  let(:muncher_api) { MuncherApi.new }

  it "must be valid" do
    value(muncher_api).must_be :valid?
  end
end
