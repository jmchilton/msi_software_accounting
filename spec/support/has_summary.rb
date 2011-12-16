module HasSummary

  share_examples_for "has summary" do

    specify "summary should contain count" do
      summary[:count].should eql(3)
    end

    specify "summary should contain first date" do
      Date.parse(summary[:first]).should eql(Date.parse('2011-08-05 12:10:38'))
    end

    specify "summary should contain last date" do
      Date.parse(summary[:last]).should eql(Date.parse('2011-08-07 12:10:38'))
    end

  end


  def setup_collectl_executions(instance)
    FactoryGirl.create(:collectl_execution, :collectl_executable => instance, :start_time => '2011-08-05 12:10:38')
    FactoryGirl.create(:collectl_execution, :collectl_executable => instance, :start_time => '2011-08-06 12:10:38')
    FactoryGirl.create(:collectl_execution, :collectl_executable => instance, :start_time => '2011-08-07 12:10:38')
  end

  def setup_flexlm_events(instance)
    FactoryGirl.create(:event, :feature => instance.identifier, :ev_date => '2011-08-05 12:10:38')
    FactoryGirl.create(:event, :feature => instance.identifier, :ev_date => '2011-08-06 12:10:38')
    FactoryGirl.create(:event, :feature => instance.identifier, :ev_date => '2011-08-07 12:10:38')
  end

end