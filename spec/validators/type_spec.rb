# frozen_string_literal: true

require "spec_helper"

RSpec.describe SimpleValidate do
  context "with allow_nil" do
    it "returns true for nils" do
      card = Class.new(Struct.new(:number)) do
        include SimpleValidate

        validates_type_of :number, as: :string, allow_nil: true
      end

      c = card.new

      expect(c.valid?).to eq(true)
    end
  end

  context "with boolean" do
    context "when valid" do
      it do
        person = Class.new(Struct.new(:alive)) do
          include SimpleValidate

          validates_type_of :alive, as: :boolean
        end

        p = person.new
        p.alive = true

        expect(p.valid?).to eq(true)
      end
    end

    context "when invalid" do
      it do
        person = Class.new(Struct.new(:alive)) do
          include SimpleValidate

          validates_type_of :alive, as: :boolean
        end

        p = person.new

        expect(p.valid?).to eq(false)
        expect(p.errors.messages[:alive].size).to eq 1
        expect(p.errors.messages[:alive]).to include("must be a boolean")
      end
    end
  end

  context "with string" do
    context "when valid" do
      it do
        person = Class.new(Struct.new(:alive)) do
          include SimpleValidate

          validates_type_of :alive, as: :string
        end

        p = person.new
        p.alive = "yes"

        expect(p.valid?).to eq(true)
      end
    end

    context "when invalid" do
      it do
        person = Class.new(Struct.new(:alive)) do
          include SimpleValidate

          validates_type_of :alive, as: :string
        end

        p = person.new

        expect(p.valid?).to eq(false)
        expect(p.errors.messages[:alive].size).to eq 1
        expect(p.errors.messages[:alive]).to include("must be a string")
      end
    end
  end

  context "with integer" do
    context "when valid" do
      it do
        person = Class.new(Struct.new(:age)) do
          include SimpleValidate

          validates_type_of :age, as: :integer
        end

        p = person.new
        p.age = 32

        expect(p.valid?).to eq(true)
      end
    end

    context "when invalid" do
      it do
        person = Class.new(Struct.new(:age)) do
          include SimpleValidate

          validates_type_of :age, as: :integer
        end

        p = person.new

        expect(p.valid?).to eq(false)
        expect(p.errors.messages[:age].size).to eq 1
        expect(p.errors.messages[:age]).to include("must be an integer")
      end
    end
  end

  context "with float" do
    context "when valid" do
      it do
        foo = Class.new(Struct.new(:num)) do
          include SimpleValidate

          validates_type_of :num, as: :float
        end

        f = foo.new
        f.num = 32.3

        expect(f.valid?).to eq(true)
      end
    end

    context "when invalid" do
      it do
        foo = Class.new(Struct.new(:num)) do
          include SimpleValidate

          validates_type_of :num, as: :float
        end

        f = foo.new

        expect(f.valid?).to eq(false)
        expect(f.errors.messages[:num].size).to eq 1
        expect(f.errors.messages[:num]).to include("must be a float")
      end
    end
  end
end
