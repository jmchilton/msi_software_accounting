module HasSummary

  share_examples_for "has summary" do
    let(:summary) { instance.summarize }

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

end