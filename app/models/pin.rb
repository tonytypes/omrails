class Pin < ActiveRecord::Base
  attr_accessible :description

  validates :description, presence: true

  # This is a Rails association (Google it).
  # This is saying a pin can only have 1 user.
  belongs_to :user

  # This "double makes sure" that if User ID
  # is not present, it won't be able to ave to the DB
  validates :user_id, presence: true
end
