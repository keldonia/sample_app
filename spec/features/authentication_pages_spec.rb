require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "login page" do
    before { visit login_path }

    it { should have_selector('h1',     text: 'Log in')}
    it { should have_selector('title',  text: 'Log in', visible: false)}
  end

  describe "login" do
    before { visit login_path }

    describe "with invalid information" do
      before { click_button "Log in" }

      it { should have_selector('title', text: 'Log in', visible: false)}
      it { should have_selector('div.alert.alert-error', text: 'Invalid')}

      describe "after visiting another page" do
        before { click link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",        with: user.Email
        fill_in "Password",     with: user.Password
        click_button "Log in"
      end

      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Log out', href: logout_path) }
      it { should_not have_link('Log in', href: login_path) }
    end
  end
end
