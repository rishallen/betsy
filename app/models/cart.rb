class Cart < ActiveRecord::Base
  validates :session_id, presence: true
end
