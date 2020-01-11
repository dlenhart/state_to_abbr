require 'rspec'
require_relative '../lib/state_to_abbr'

RSpec.describe StateToAbbr do
  it "has a version number" do
    expect(StateToAbbr::VERSION).not_to be nil
  end

  it "converts Alaska to abbreviation" do
    state = 'Alaska'
    expect(StateToAbbr::Abbr.convert(state)).to eq('AK')
  end
end
