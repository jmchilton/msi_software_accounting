# Base ideas from http://blog.zobie.com/2009/01/read-only-models-in-activerecord/
class ReadOnlyModel < ActiveRecord::Base
  before_destroy :prevent_read_only

  # Prevent creation of new records and modification to existing records
  def readonly?
    return true
  end

  # Prevent objects from being destroyed
  def prevent_read_only
    raise ActiveRecord::ReadOnlyRecord
  end

end