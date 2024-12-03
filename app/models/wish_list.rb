class WishList < ApplicationRecord
  belongs_to :participant
  
  validates :item, presence: true
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :font_reference, length: { maximum: 500 }, allow_blank: true
end
