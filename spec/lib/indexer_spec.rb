require 'spec_helper'

describe Indexer do
  describe "index_raw_records" do
    it "should not index collectl records" do
      CollectlExecution.should_receive(:index_raw_records)
      FlexlmAppSnapshot.should_receive(:index_raw_records)
      Indexer.index_raw_records
    end

  end
end
