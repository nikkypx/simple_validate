# frozen_string_literal: true

module SimpleValidate
  class ValidatesBase
    attr_accessor :message, :attribute, :condition

    def initialize(attribute, message, condition)
      @message   = message
      @attribute = attribute
      @condition = condition
    end
  end
end
