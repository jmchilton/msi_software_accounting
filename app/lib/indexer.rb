module Indexer

  # Entry point for indexing cron job
  def self.index_raw_records
    CollectlExecution.index_raw_records
  end

end