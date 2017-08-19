
class Trip < ActiveRecord::Base
  acts_as_copy_target #this is from the postgres-copy gem

end
