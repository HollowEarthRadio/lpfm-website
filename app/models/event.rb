class Event < ActiveRecord::Base
  scope :public, -> { where(public: true) }

  #has_attached_file :event_image, styles: { cropped: '200x200!' }

  has_attached_file :event_image,
    storage: :s3,
    url: ":s3_domain_url",
    path: ":class/:attachment/:id_partition/:style/:filename",
    s3_protocol: 'http',
    s3_credentials: {
      bucket:            "hollowearth-event-images",
      access_key_id:     ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET'],
    },
    styles: { cropped: '200x200!' }

end
