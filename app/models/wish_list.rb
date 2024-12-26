class WishList < ApplicationRecord
  belongs_to :participant
  
  validates :item, presence: true
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :font_reference, length: { maximum: 500 }, allow_blank: true

  def fetch_links
    return links if links.present?

    service = ChatGPTService.new
    self.links = service.generate_links(name)
    save!
    links
  end  
end
