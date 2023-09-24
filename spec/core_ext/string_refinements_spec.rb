# frozen_string_literal: true

require "spec_helper"

RSpec.describe "#to_camel" do
  using CoreExt::StringRefinements

  it "converts snake_case to CamelCase" do
    expect("data_engineering".to_camel).to eq("DataEngineering")
  end

  it "handles single word strings" do
    expect("ruby".to_camel).to eq("Ruby")
  end

  it "leaves CamelCase strings unchanged" do
    expect("CamelCase".to_camel).to eq("CamelCase")
  end

  it "handles empty strings" do
    expect("".to_camel).to eq("")
  end
end
