require 'set'

module SimpleValidate
  class ValidatesExclusionOf < ValidatesBase
    attr_accessor :exclusion, :options

    def initialize(attribute, options)
      self.options = options
      self.exclusion = Set.new(Array(options[:in]).map(&:to_s))
      super(attribute, options[:message] || "is not allowed", options[:if] || Proc.new { true })
    end

    def valid?(instance)
      raise ArgumentError if exclusion.empty? || !options.fetch(:in).is_a?(Array)
      !exclusion.include?("#{instance.send(attribute)}")
    end
  end
end
