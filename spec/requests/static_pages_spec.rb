require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "Home page" do
    it "should have the content 'Sample App'" do
      get 'static_pages/home'
      page.should have_content('Sample App')
    end
  end
end
