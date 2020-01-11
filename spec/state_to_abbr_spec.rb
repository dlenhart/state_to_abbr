require 'rspec'
require_relative '../lib/state_to_abbr'

RSpec.describe StateToAbbr do
  it "has a version number" do
    expect(StateToAbbr::VERSION).not_to be nil
  end

  # lets be lazy, load the yaml file and run through all the states.
  states = YAML.load_file(File.join(__dir__, '../lib/united_states_and_territories.yml'))

  states.each do |state, abbr|
    it "converts #{state} to abbreviation (#{abbr})" do
      expect(StateToAbbr::Abbr.convert(state)).to eq(abbr), "Expected \"#{state} to convert to: #{abbr}"
    end

    it "converts #{abbr} to state (#{state})" do
      expect(StateToAbbr::Abbr.convert(abbr)).to eq(state), "Expected \"#{abbr} to convert to: #{state}"
    end
  end

end
