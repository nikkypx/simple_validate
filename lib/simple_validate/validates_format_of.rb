# frozen_string_literal: true

module SimpleValidate
  class ValidatesFormatOf < ValidatesBase
    attr_accessor :regex

    def initialize(attribute, options)
      @allow_nil = options[:allow_nil]
      @regex = options[:with]
      super(
        attribute,
        options[:message] || "is incorrect format",
        options[:if] || proc { true }
      )
    end

    def valid?(instance)
      return true if super

      raise ArgumentError if regex.nil? || !regex.is_a?(Regexp)

      !!(@val =~ regex)
    end
  end
end
