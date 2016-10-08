module SimpleValidate
  class ValidatesFormatOf < ValidatesBase
    attr_accessor :regex

    def initialize(attribute, options)
      self.regex = options[:with]
      super(attribute, options[:message] || "is incorrect format", options[:if] || Proc.new { true })
    end

    def valid?(instance)
      !!(instance.send(attribute) =~ regex)
    end
  end
end
