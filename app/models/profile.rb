class Profile < ActiveRecord::Base
	has_attached_file :avatar, default_url: '/assets/default-avatar.png'

	belongs_to :user

	validates :name, presence: true
	validates :age, numericality: { only_integer: true }, allow_nil: true
end
