class Program < ActiveRecord::Base
  has_and_belongs_to_many :users, -> { uniq }

  scope :scheduled, -> { where(archived: false) }
  scope :random,  -> { scheduled.sample }
  scope :current, -> { where(is_broadcasting: true).order("updated_at desc").first }

  has_attached_file :program_image, styles: { medium: "320x240>", thumbnail: "50x50!" }
end
