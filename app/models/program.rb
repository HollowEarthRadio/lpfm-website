class Program < ActiveRecord::Base
  has_and_belongs_to_many :users, -> { uniq }

  scope :scheduled, -> { where(archived: false) }
  scope :random,  -> { scheduled.sample }
  scope :current, -> { where(is_broadcasting: true).order("updated_at desc").first }

  #has_attached_file :program_image, styles: { medium: "320x240>", thumbnail: "50x50!" }

  has_attached_file :program_image,
    storage: :s3,
    url: ":s3_domain_url",
    path: ":class/:attachment/:id_partition/:style/:filename",
    s3_protocol: 'http',
    s3_credentials: {
      bucket:            "hollowearth-program-images",
      access_key_id:     ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET'],
    },
    styles: { main: "320x320>", medium: "320x240", thumbnail: "50x50!" }

end
