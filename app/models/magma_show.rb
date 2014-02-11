class MagmaShow < ActiveRecord::Base

  def title
    "#{date.strftime("%b %d")} #{venue}"
  end

  has_attached_file :poster_image,
    storage: :s3,
    url: ":s3_domain_url",
    path: ":class/:attachment/:id_partition/:style/:filename",
    s3_protocol: 'http',
    s3_credentials: {
      bucket:            "hollowearth-poster-images",
      access_key_id:     ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET'],
    },
    styles: { thumbnail: "140x193!" }
end
