every :day, :at => '1:36am' do
  runner "Indexer.index_raw_records"
end