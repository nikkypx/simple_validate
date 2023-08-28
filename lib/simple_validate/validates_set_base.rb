# frozen_string_literal: true

module SimpleValidate
  class ValidatesSetBase < ValidatesBase
    attr_accessor :set, :options

    def initialize(attribute, options)
      self.options = options
      self.set = Set.new(Array(options[:in]).map(&:to_s))
      super(attribute, options[:message] ||
        "breaks inclusion/exclusion rules", options[:if] || proc { true })
    end
  end
end
