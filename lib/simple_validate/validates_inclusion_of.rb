require 'set'

module SimpleValidate
  class ValidatesInclusionOf < ValidatesBase
    attr_accessor :inclusion, :options

    def initialize(attribute, options)
      self.options = options
      self.inclusion = Set.new(Array(options[:in]).map(&:to_s))
      super(attribute, options[:message] || "is not included in set", options[:if] || Proc.new { true })
    end

    def valid?(instance)
      raise ArgumentError if inclusion.empty? || !options.fetch(:in).is_a?(Array)
      inclusion.include?("#{instance.send(attribute)}")
    end
  end
end
