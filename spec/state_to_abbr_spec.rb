require 'rspec'
require_relative '../lib/state_to_abbr'

RSpec.describe StateToAbbr do
  it "has a version number" do
    expect(StateToAbbr::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
