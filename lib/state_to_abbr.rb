# frozen_string_literal: true

require 'state_to_abbr/version.rb'
require 'yaml'

module StateToAbbr
  class Abbr
    attr_reader :string

    def initialize(string)
      @data = YAML.load_file('../data/states.yml')
      @string = string
    end

    def self.convert(string, method: :convert_abbr_or_state)
      Abbr.new(string).send(method)
    end

    private

    def abbr?(str)
      true if str.size <= 2
    end

    def state?(str)
      true if str.size >= 3
    end

    def inverted_data
      @data.invert.freeze
    end

    def normal_data
      @data
    end

    def determine_type
      return _raise_error if string.to_s.strip.empty?

      abbr?(string) ? string.upcase : string.downcase.capitalize
    end

    def determine_output(data, str)
      send(data.to_s).include?(str) ? send(data.to_s)[str] : _raise_error
    end

    def convert_abbr_or_state
      str = determine_type

      state = if abbr?(str)
                determine_output(:inverted_data, str)
              elsif state?(str)
                determine_output(:normal_data, str)
              end
      state
    end

    def _raise_error
      raise "Unable to convert \"#{string}\", please check spelling!"
    end
  end
end
puts "#{StateToAbbr::Abbr.convert(' ')}"
