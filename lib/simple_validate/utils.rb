# frozen_string_literal: true

module SimpleValidate
  module Utils
    def self.camelize(input) = input.to_s.split("_").map(&:capitalize).join
    def self.extract_options!(args) = args.last.is_a?(Hash) ? args.pop : {}
    def self.classify(input) = Object.const_get(camelize(input))

    def self.article(input)
      vowels = %w[a e i o u]
      vowels.include?(input[0]) ? "an" : "a"
    end
  end
end
