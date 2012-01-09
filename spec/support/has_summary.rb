module HasSummary
  TEST_SUMMARY_OLDEST_USE = '2011-08-05 12:10:38'
  TEST_SUMMARY_NEWEST_USE = '2011-08-07 12:10:38'
  share_examples_for "has summary" do

    specify "summary should contain count" do
      summary[:count].should eql(3)
    end

    specify "summary should contain first date" do
      Date.parse(summary[:first]).should eql(Date.parse(TEST_SUMMARY_OLDEST_USE))
    end

    specify "summary should contain last date" do
      Date.parse(summary[:last]).should eql(Date.parse(TEST_SUMMARY_NEWEST_USE))
    end

  end

  shared_examples_for "has direct summary" do
    let(:summary) { instance.summarize }

    it_should_behave_like "has summary"

  end

  def setup_module_loads(instance)
    for_test_times do |date|
      FactoryGirl.create(:module_load, :module => instance, :date => date)
    end
  end

  def setup_collectl_executions(instance)
    for_test_times do |date|
      FactoryGirl.create(:collectl_execution, :collectl_executable => instance, :start_time => date)
    end
  end

  def setup_flexlm_events(instance)
    for_test_times do |date|
      FactoryGirl.create(:event, :feature => instance.identifier, :ev_date => date)
    end
  end

  private

  def for_test_times(&block)
    [TEST_SUMMARY_OLDEST_USE, '2011-08-06 12:10:38', TEST_SUMMARY_NEWEST_USE].each &block
  end

end