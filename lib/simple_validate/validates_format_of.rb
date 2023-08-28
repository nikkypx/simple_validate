# frozen_string_literal: true

module SimpleValidate
  class ValidatesFormatOf < ValidatesBase
    attr_accessor :regex

    def initialize(attribute, options)
      @regex = options[:with]
      super(attribute, options[:message] ||
        "is incorrect format", options[:if] || proc { true })
    end

    def valid?(instance)
      raise ArgumentError if regex.nil? || !regex.is_a?(Regexp)

      !!(instance.send(attribute) =~ regex)
    end
  end
end
