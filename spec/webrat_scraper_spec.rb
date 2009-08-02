require File.dirname(__FILE__) + '/spec_helper'

describe WebratScraper do
  describe "instance methods" do
    describe "#doc" do
      it "is a Nokogiri object of of the response body" do
        scraper = WebratScraper.new
        scraper.visit "http://www.google.com/"
        scraper.doc.class.should == Nokogiri::HTML::Document
      end
    end
    
  end
  
end
