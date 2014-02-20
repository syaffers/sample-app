require 'spec_helper'

describe "papers/new" do
  before(:each) do
    assign(:paper, stub_model(Paper,
      :title => "MyString",
      :url => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new paper form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", papers_path, "post" do
      assert_select "input#paper_title[name=?]", "paper[title]"
      assert_select "input#paper_url[name=?]", "paper[url]"
      assert_select "input#paper_user_id[name=?]", "paper[user_id]"
    end
  end
end
