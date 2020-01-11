# frozen_string_literal: true

require 'state_to_abbr/version.rb'
require 'yaml'

module StateToAbbr
  class Abbr
    attr_reader :string

    def initialize(string)
      @data = YAML.load_file(File.join(__dir__, 'united_states_and_territories.yml'))
      @string = string
    end

    def self.convert(string)
      Abbr.new(string).send(:convert_abbr_or_state)
    end

    private

    def abbreviations_to_states
      @data.invert.freeze
    end

    def states_to_abbreviations
      @data.freeze
    end

    def abbr?(str)
      true if str.size <= 2
    end

    def state?(str)
      true if str.size >= 3
    end

    def capitalize_all_words
      string.downcase.split.map(&:capitalize).join(' ')
    end

    def determine_type
      return _raise_error if string.to_s.strip.empty?

      abbr?(string) ? string.upcase : capitalize_all_words
    end

    def determine_output(data, str)
      send(data.to_s).include?(str) ? send(data.to_s)[str] : _raise_error
    end

    def convert_abbr_or_state
      str = determine_type

      state = if abbr?(str)
                determine_output(:abbreviations_to_states, str)
              elsif state?(str)
                determine_output(:states_to_abbreviations, str)
              end
      state
    end

    def _raise_error
      raise "Unable to convert \"#{string}\", please check spelling!"
    end
  end
end
