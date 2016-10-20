module SimpleValidate
  class ValidatesInclusionOf < ValidatesSetBase

    def valid?(instance)
      raise ArgumentError if set.empty? || !options.fetch(:in).is_a?(Array)
      set.include?("#{instance.send(attribute)}")
    end
  end
end
