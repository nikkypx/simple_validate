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

  context "with multiple errors on same attribute" do
    it "correctly assigns to same key" do
      card = Class.new(Struct.new(:type, :number)) do
        include SimpleValidate

        validates_length_of :type, in: [2]
        validates_inclusion_of :type, in: ["VI"]
      end

      card = card.new
      card.type = "VIM"

      expect(card.valid?).to eq(false)
      expect(card.errors.messages[:type].size).to eq(2)
    end
  end
end
