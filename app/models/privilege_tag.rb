class PrivilegeTag < ActiveRecord::Base
  attr_accessible :name_tag, :priority
  has_many :privileges
end
