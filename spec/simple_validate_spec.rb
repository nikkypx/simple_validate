# frozen_string_literal: true

require "spec_helper"

RSpec.describe SimpleValidate do
  context "with presence" do
    it do
      person = Class.new(Struct.new(:name, :age)) do
        include SimpleValidate

        validates_presence_of :name, :age
      end

      p = person.new

      expect(p.valid?).to eq(false)
      expect(p.errors.messages[:name].size).to eq(1)
      expect(p.errors.messages[:age].size).to eq(1)
      expect(p.errors.messages[:name]).to include("can't be empty")
      expect(p.errors.messages[:age]).to include("can't be empty")
    end
  end

  context "with type" do
    it do
      person = Class.new(Struct.new(:name, :age, :height)) do
        include SimpleValidate

        validates_type_of :name, as: :string
        validates_type_of :age, as: :integer
        validates_type_of :height, as: :float
      end

      p = person.new

      expect(p.valid?).to eq(false)
      expect(p.errors.messages[:name].size).to eq(1)
      expect(p.errors.messages[:age].size).to eq(1)
      expect(p.errors.messages[:height].size).to eq(1)
      expect(p.errors.messages[:name]).to include("must be a string")
      expect(p.errors.messages[:age]).to include("must be an integer")
      expect(p.errors.messages[:height]).to include("must be a float")
    end
  end

  context "with inclusion" do
    it do
      card = Class.new(Struct.new(:type, :number)) do
        include SimpleValidate

        validates_inclusion_of :type, in: %w[VI MC]
      end

      card = card.new

      expect(card.valid?).to eq(false)
      expect(card.errors.messages[:type]).to include("breaks inclusion/exclusion rules")

      card.type = "VI"
      expect(card.valid?).to eq(true)
    end
  end

  context "with length" do
    it do
      card = Class.new(Struct.new(:type, :number)) do
        include SimpleValidate

        validates_length_of :type, in: [2]
      end

      card = card.new
      card.type = "VIM"

      expect(card.valid?).to eq(false)
      expect(card.errors.messages[:type]).to include("is not the correct length")
    end
  end
end
