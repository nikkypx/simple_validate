# frozen_string_literal: true

module SimpleValidate
  class ValidatesInclusionOf < ValidatesSetBase
    def valid?(instance)
      raise ArgumentError if set.empty? || !options.fetch(:in).is_a?(Array)

      set.include?(instance.__send__(attribute).to_s)
    end
  end
end
