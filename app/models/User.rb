class User < ActiveRecord::Base

    has_many :tickets
    has_many :venues, through: :tickets

    validates :userName, presence: true
    validates :userName, uniqueness: { message: 'That user name already exists.' }
    validates :userName, length: { maximum: 10,
      too_long: "10 characters is the maximum allowed" }

end