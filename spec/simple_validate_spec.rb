# frozen_string_literal: true

require "spec_helper"

RSpec.describe SimpleValidate do
  context "with presence" do
    it do
      Person = Class.new(Struct.new(:name, :age)) do
        include SimpleValidate

        validates_presence_of :name, :age
      end

      p = Person.new

      expect(p.valid?).to eq(false)
      expect(p.errors.messages[:name]).to include("can't be empty")
      expect(p.errors.messages[:age]).to include("can't be empty")
    end
  end

  context "with type" do
    it do
      Person = Class.new(Struct.new(:name, :age, :height)) do
        include SimpleValidate

        validates_type_of :name, as: :string
        validates_type_of :age, as: :integer
        validates_type_of :height, as: :float
      end

      p = Person.new

      expect(p.valid?).to eq(false)
      expect(p.errors.messages[:name]).to include("must be a string")
      expect(p.errors.messages[:age]).to include("must be an integer")
      expect(p.errors.messages[:height]).to include("must be a float")
    end
  end
end
