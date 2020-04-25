# frozen_string_literal: true

module SimpleValidate
  class ValidatesBase
    attr_accessor :message, :attribute, :condition

    def initialize(attribute, message, condition)
      self.message   = message
      self.attribute = attribute
      self.condition = condition
    end
  end
end
