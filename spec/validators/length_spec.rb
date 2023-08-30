# frozen_string_literal: true

require "spec_helper"

RSpec.describe SimpleValidate do
  context "with allow_nil" do
    it "returns true for nils" do
      card = Class.new(Struct.new(:type, :number)) do
        include SimpleValidate

        validates_length_of :type, is: 2, allow_nil: true
      end

      c = card.new

      expect(c.valid?).to eq(true)
    end
  end

  context "with maximum" do
    it do
      card = Class.new(Struct.new(:type, :number)) do
        include SimpleValidate

        validates_length_of :type, maximum: 100
      end

      c = card.new
      c.type = "a" * 101

      expect(c.valid?).to eq(false)
      expect(c.errors.messages[:type].size).to eq 1
      expect(c.errors.messages[:type]).to include "is too long"
    end
  end

  context "with minimum" do
    it do
      card = Class.new(Struct.new(:type, :number)) do
        include SimpleValidate

        validates_length_of :type, minimum: 100
      end

      c = card.new
      c.type = "a" * 99

      expect(c.valid?).to eq(false)
      expect(c.errors.messages[:type].size).to eq 1
      expect(c.errors.messages[:type]).to include "is too short"
    end
  end

  context "with in" do
    context "when valid" do
      it do
        card = Class.new(Struct.new(:type, :number)) do
          include SimpleValidate

          validates_length_of :type, in: 100..105
        end

        c = card.new
        c.type = "a" * 101

        expect(c.valid?).to eq(true)
      end
    end

    context "when invalid" do
      it do
        card = Class.new(Struct.new(:type, :number)) do
          include SimpleValidate

          validates_length_of :type, in: 100..105
        end

        c = card.new
        c.type = "a" * 99

        expect(c.valid?).to eq(false)
        expect(c.errors.messages[:type].size).to eq 1
        expect(c.errors.messages[:type]).to include "is not valid length"
      end
    end
  end

  context "with is" do
    context "when valid" do
      it do
        card = Class.new(Struct.new(:type, :number)) do
          include SimpleValidate

          validates_length_of :type, is: 100
        end

        c = card.new
        c.type = "a" * 100

        expect(c.valid?).to eq(true)
      end
    end

    context "when invalid" do
      it do
        card = Class.new(Struct.new(:type, :number)) do
          include SimpleValidate

          validates_length_of :type, is: 100
        end

        c = card.new
        c.type = "a" * 99

        expect(c.valid?).to eq(false)
        expect(c.errors.messages[:type].size).to eq 1
        expect(c.errors.messages[:type]).to include "is not valid length"
      end
    end
  end

  context "with multiple calls to valid?" do
    it "does not duplicate errors" do
      card = Class.new(Struct.new(:type, :number)) do
        include SimpleValidate

        validates_length_of :type, in: [2]
      end

      c = card.new

      c.valid?
      c.valid?
      c.valid?
      c.valid?

      expect(c.errors.messages[:type].size).to eq(1)
    end
  end
end
