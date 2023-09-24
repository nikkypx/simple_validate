# frozen_string_literal: true

module CoreExt
  module StringRefinements
    refine String do
      def to_camel
        return self if self =~ /^[A-Z][a-z]*([A-Z][a-z]*)*$/

        split("_").map(&:capitalize).join
      end

      def article
        vowels = %w[a e i o u A E I O U]
        vowels.include?(self[0]) ? "an" : "a"
      end
    end
  end
end
