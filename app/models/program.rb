class Program < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates_format_of :twitter_id,
    with: /\A[A-Za-z0-9_]{1,15}\z/,
    allow_nil: true,
    allow_blank: true,
    message: "id's can only contain the letters (A-Z), numbers (0-9) or underscore. No @ symbols."

  scope :scheduled, -> { where(archived: false) }
  scope :random,  -> { scheduled.sample }
  scope :current, -> { where(is_broadcasting: true).order("updated_at desc").first }

  has_attached_file :program_image,
    storage: :s3,
    url: ":s3_domain_url",
    path: ":class/:attachment/:id_partition/:style/:filename",
    s3_protocol: 'https',
    s3_region: "us-west-2",
    s3_credentials: {
      bucket: "hollowearth-program-images",
    },
    styles: { main: "320x320>", medium: "300", thumbnail: "50x50!" }

  validates :program_image, attachment_content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
