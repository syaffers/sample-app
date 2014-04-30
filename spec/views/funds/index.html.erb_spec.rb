require 'spec_helper'

describe "funds/index" do
  before(:each) do
    assign(:funds, [
      stub_model(Fund,
        :needed => 1.5,
        :collected => ""
      ),
      stub_model(Fund,
        :needed => 1.5,
        :collected => ""
      )
    ])
  end

  it "renders a list of funds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
