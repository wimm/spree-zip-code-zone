require File.dirname(__FILE__) + '/../spec_helper'

describe ZipCodeRange do
  before(:each) do
    @zip_code_range = Factory.build(:zip_code_range)
  end

  it "should be valid" do
    @zip_code_range.should be_valid
  end
end
