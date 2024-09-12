class Channel < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :channel_id, presence: true
  validates :channel_name, presence: true
end
