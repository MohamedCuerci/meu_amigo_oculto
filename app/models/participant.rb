class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :secret_santa
end
