# frozen_string_literal: true

require "spec_helper"

RSpec.describe SimpleValidate do
  context "with allow_nil" do
    it "returns true for nils" do
      foo = Class.new(Struct.new(:number)) do
        include SimpleValidate

        validates_exclusion_of :number, in: 5..10, allow_nil: true
      end

      f = foo.new

      expect(f.valid?).to eq(true)
    end
  end

  context "with exclusion" do
    context "when valid" do
      it do
        foo = Class.new(Struct.new(:number)) do
          include SimpleValidate

          validates_exclusion_of :number, in: 5..10
        end

        f = foo.new
        f.number = 11

        expect(f.valid?).to eq(true)
      end
    end

    context "when invalid" do
      it do
        foo = Class.new(Struct.new(:number)) do
          include SimpleValidate

          validates_exclusion_of :number, in: 5..10
        end

        f = foo.new
        f.number = 6

        expect(f.valid?).to eq(false)
      end
    end
  end
end
