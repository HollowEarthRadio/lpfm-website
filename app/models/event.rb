class Event < ActiveRecord::Base
  scope :public,        -> { where(public: true) }
  scope :with_startime, -> { where(no_start_time: false) }
  scope :featured,      -> { where(featured: true) }
  scope :not_featured,  -> { where.not(featured: true) }
  scope :static,        -> { where(no_start_time: true).public }
  scope :this_week,     -> { where(start_time: DateTime.now..(DateTime.now+1.week)) }

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
    styles: { cropped: '200x200>' }

  def local_start_time
    local_time = self.start_time.in_time_zone(Rails.application.config.time_zone)
    "#{local_time.strftime('%a %b %e - %l:%M %p')}"
  end

end
