require 'spec_helper'

describe "funds/show" do
  before(:each) do
    @fund = assign(:fund, stub_model(Fund,
      :needed => 1.5,
      :collected => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1.5/)
    rendered.should match(//)
  end
end
