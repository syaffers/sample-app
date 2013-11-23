require 'spec_helper'

describe "static pages" do
  describe "Home page" do
    it "should have the content 'Sample App'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end
    
    it "should have the base title" do
      visit "/static_pages/home"
      expect(page).to have_title('Ruby on Rails Tutorial Sample App')
    end
    
    it "should not have the custom title" do
      visit "/static_pages/home"
      expect(page).not_to have_title('| Home')
    end
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    
    it "should have the right title" do
      visit "/static_pages/help"
      expect(page).to have_title('Help')
    end
  end
  
  describe "About page" do
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end
    
    it "should have the right title" do
      visit "/static_pages/about"
      expect(page).to have_title('About Us')
    end
  end
  
  describe "Contact page" do
    it "should have the content 'Contact Us'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact Us')
    end
    
    it "should have the right title" do
      visit '/static_pages/contact'
      expect(page).to have_title('Contact Us')
    end
  end
end

