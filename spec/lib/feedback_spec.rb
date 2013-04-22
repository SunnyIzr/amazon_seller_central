require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Feedback" do
  before :all do
    @feedback = AmazonSellerCentral::Feedback.new
  end
  %w{date rating comments arrived_on_time item_as_described customer_service order_id rater_email rater_role}.each do |expected_attribute|
    it "Has an attribute \"#{expected_attribute}\"" do
      @feedback.send("#{expected_attribute}=", "foo")
      @feedback.send(expected_attribute).should == "foo"
    end
  end

  it "should parse the date correctly" do
    #stream = File.read(File.expand_path(File.dirname(__FILE__) + '/../support/sample_pages/Feedback Page 1.html'))
    #FakeWeb.register_uri(:get, 'https://sellercentral.amazon.com/feedback/', :body => stream, :content_type => 'text/html')
    #agent = Mechanize.new
    #page = agent.get('https://sellercentral.amazon.com/feedback/')
    #fp = AmazonSellerCentral::FeedbackPage.new(:page => page, :agent => agent)
    fp = AmazonSellerCentral::FeedbackPage.load_first_page
    f = fp.parse
    feedback_date = f.first.date
    feedback_date.year.should == 2011
    feedback_date.month.should == 7
    feedback_date.day.should == 3
  end
end