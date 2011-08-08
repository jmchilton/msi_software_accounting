# Base ideas from http://blog.zobie.com/2009/01/read-only-models-in-activerecord/
class ReadOnlyModel < ActiveRecord::Base
  before_destroy :prevent_destroy

  # Prevent creation of new records and modification to existing records
  def readonly?
    return true
  end

  # Prevent objects from being destroyed
  def prevent_destroy
    raise ActiveRecord::ReadOnlyRecord
  end

  def self.delete_all
    raise ActiveRecord::ReadOnlyRecord
  end

  def delete
    raise ActiveRecord::ReadOnlyRecord
  end

end