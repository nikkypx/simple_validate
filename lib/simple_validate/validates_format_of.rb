# frozen_string_literal: true

module SimpleValidate
  class ValidatesFormatOf < ValidatesBase
    attr_accessor :regex

    def initialize(attribute, options)
      @allow_nil = options[:allow_nil]
      @regex = options[:with]

      raise ArgumentError, "must supply a Regexp via the :with option" unless @regex.is_a?(Regexp)

      super(
        attribute,
        options[:message] || "is incorrect format",
        options[:if] || proc { true }
      )
    end

    def valid?(instance)
      return true if super

      !!(@val =~ regex)
    end
  end
end
