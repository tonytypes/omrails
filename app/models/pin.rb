class Pin < ActiveRecord::Base
  attr_accessible :description, :image, :image_remote_url

  validates :description, presence: true

  # This is a Rails association (Google it).
  # This is saying a pin can only have 1 user.
  belongs_to :user
  # This "double makes sure" that if User ID
  # is not present, it won't be able to ave to the DB
  validates :user_id, presence: true

	# Creates a paperclip-provided association
	# and validates
  has_attached_file :image, styles: { medium: "320x240>" }
 	validates_attachment :image, presence: true,
			  											 content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
			  											 size: { less_than: 5.megabytes }

  def image_remote_url=(url_value)
    self.image = URI.parse(url_value) unless url_value.blank?
    super
  end

end
