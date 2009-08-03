require File.dirname(__FILE__) + '/spec_helper'

describe WebratScraper do
  describe "instance methods" do
    before(:all) do
      FakeWeb.register_uri(:get, "http://example.com/", :body => "Hello World!")
    end
    
    before(:each) do
      @session = WebratScraper.new
    end
    
    describe "#doc" do
      it "is a Nokogiri object of of the response body" do
        @session.visit "http://www.example.com/"
        @session.doc.class.should == Nokogiri::HTML::Document
      end
    end
    
    describe "#user_agent=" do
      it "sets the user_agent" do
        @session.user_agent = user_agent = "Test User Agent 1.0"
        @session.visit "http://www.example.com/"
        @session.user_agent.should == user_agent
        @session.mechanize.user_agent.should == user_agent
      end
    end
  end
  
  describe "webrat's methods" do
    before(:all) do
      FakeWeb.register_uri(:get,  "http://example.com/", :body => "Hello World!")
      FakeWeb.register_uri(:get,  "http://example.com/1", :body => "Hello World 1!")
      FakeWeb.register_uri(:get,  "http://example.com/2", :body => "Hello World 2!")
      FakeWeb.register_uri(:get,  "http://example.com/form", :body => open_fixture("fake_form.html"))
      FakeWeb.register_uri(:post, "http://example.com/action", :body => open_fixture("fake_form_action.html"))
    end
    
    before(:each) do
      @session = WebratScraper.new
    end

    describe "#visit" do
      it "visits a webpage and updates the context" do
        @session.visit("http://example.com/")
        @session.doc.inner_text.should == "Hello World!"
        
        @session.visit("http://example.com/1")
        @session.doc.inner_text.should == "Hello World 1!"
      end
    end
    
    describe "#fill_in" do
      it "fills in a form field with a value" do
        @session.visit "http://example.com/form"
        lambda {@session.fill_in "Username", :with => "who"}.should_not raise_error
      end
    end
    
    describe "#click_link" do
      it "clicks a link" do
        @session.visit "http://example.com/form"
        @session.click_link "Page two"
        @session.doc.inner_text.should == "Hello World 2!"
      end
    end
    
    describe "#click_button" do
      it "clicks a button" do
        @session.visit "http://example.com/form"
        @session.click_button "Save"
        (@session.doc/"body").inner_text.strip.should == "Form Post!"
      end
    end
    
    describe "#assert_contain" do
      it "asserts that the page contains the string given" do
        @session.visit "http://example.com/form"
        lambda { @session.assert_contain("Lorem ipsum dolor sit amet") }.should_not raise_error
      end
    end
  end
end

# Spec these out
# assert_contain (Webrat::Matchers)
# assert_have_no_selector (Webrat::Matchers)
# assert_have_no_tag (Webrat::HaveTagMatcher)
# assert_have_no_xpath (Webrat::Matchers)
# assert_have_selector (Webrat::Matchers)
# assert_have_tag (Webrat::HaveTagMatcher)
# assert_have_xpath (Webrat::Matchers)
# assert_not_contain (Webrat::Matchers)
# attach_file (Webrat::Scope)
# automate (Webrat::Session)
# basic_auth (Webrat::Session)
# check (Webrat::Scope)
# check_for_infinite_redirects (Webrat::Session)
# choose (Webrat::Scope)
# click_area (Webrat::Scope)
# click_button (Webrat::Scope)
# click_link (Webrat::Scope)
# click_link_within (Webrat::Session)
# contain (Webrat::Matchers)
# dom (Webrat::Session)
# field_by_xpath (Webrat::Locators)
# field_labeled (Webrat::Locators)
# field_named (Webrat::Locators)
# field_with_id (Webrat::Locators)
# fill_in (Webrat::Scope)
# have_selector (Webrat::Matchers)
# have_tag (Webrat::HaveTagMatcher)
# have_xpath (Webrat::Matchers)
# header (Webrat::Session)
# http_accept (Webrat::Session)
# infinite_redirect_limit_exceeded? (Webrat::Session)
# internal_redirect? (Webrat::Session)
# match_selector (Webrat::Matchers)
# match_tag (Webrat::HaveTagMatcher)
# match_xpath (Webrat::Matchers)
# mode= (Webrat::Configuration)
# open_in_browser (Webrat::SaveAndOpenPage)
# redirected_to (Webrat::Session)
# reload (Webrat::Session)
# save_and_open_page (Webrat::SaveAndOpenPage)
# scoped_dom (Webrat::Scope)
# select (Webrat::Scope)
# select_date (Webrat::Scope)
# select_datetime (Webrat::Scope)
# select_time (Webrat::Scope)
# set_hidden_field (Webrat::Scope)
# simulate (Webrat::Session)
# submit_form (Webrat::Scope)
# uncheck (Webrat::Scope)
# visit (Webrat::Session)
# within (Webrat::Session)
# xml_content_type? (Webrat::Session)


