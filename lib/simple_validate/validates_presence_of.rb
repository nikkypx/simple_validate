module SimpleValidate
  class ValidatesPresenceOf < ValidatesBase
    def initialize(attribute, options)
      super(attribute, options[:message] || "can't be empty", options[:if] || Proc.new { true })
    end

    def valid?(instance)
      !instance.send(attribute).nil?
    end
  end
end
