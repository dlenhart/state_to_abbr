# frozen_string_literal: true

require 'state_to_abbr/version.rb'
require 'yaml'

module StateToAbbr

  # A class for converting a state to abbreviation or vice versa
  #
  class Abbr
    attr_reader :string

    def initialize(string)
      @data = YAML.load_file(File.join(__dir__, 'united_states_and_territories.yml'))
      @string = string
    end

    # Returns converted state or it's abbr
    # @param string - string to be converted
    #
    def self.convert(string)
      Abbr.new(string).send(:convert_abbr_or_state)
    end

    private

    # Return abbreviation->state hash
    #
    def abbreviations_to_states
      @data.invert.freeze
    end

    # Return states->abbreviation hash
    #
    def states_to_abbreviations
      @data.freeze
    end

    # Is abbreviation?
    # @param str
    #
    def abbr?(str)
      true if str.size <= 2
    end

    # Is state?
    # @param str
    #
    def state?(str)
      true if str.size >= 3
    end

    # Return each word capitalized
    #
    def capitalize_all_words
      string.downcase.split.map(&:capitalize).join(' ')
    end

    # Determine if abbreviation or state
    # Return formatted state/abbreviation
    #
    def determine_type
      return _raise_error if string.to_s.strip.empty?

      abbr?(string) ? string.upcase : capitalize_all_words
    end

    # Return state/abbr from appropriate hash
    # @param data - states and or abbr hash
    # @param str - key to return from hash
    #
    def determine_output(data, str)
      send(data.to_s).include?(str) ? send(data.to_s)[str] : _raise_error
    end

    # Return converted state or abbreviation
    #
    def convert_abbr_or_state
      str = determine_type

      state = if abbr?(str)
                determine_output(:abbreviations_to_states, str)
              elsif state?(str)
                determine_output(:states_to_abbreviations, str)
              end
      state
    end

    # Raise standard error with custom message
    def _raise_error
      raise StandardError.new "Unable to convert \"#{string}\", please check spelling!"
    end
  end
end
