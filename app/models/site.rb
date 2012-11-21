class Site < ActiveRecord::Base
  attr_accessible :description, :hostname, :layout, :name
  
  belongs_to		:user
  
  validates			:name, presence: true, length: {maximum: 32}
  VALID_HOSTNAME_REGEX = "^(([a-zA-Z]|[a-zA-Z][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9])$";
  validates			:hostname, presence: true, length: {maximum: 255}
  validates			:layout, presence: true
  validates			:user_id, presence: true
  
  default_scope order: 'sites.created_at DESC'
end
