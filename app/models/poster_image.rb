class PosterImage < ActiveRecord::Base
  belongs_to :magma_show
  validates :attachment, attachment_presence: true
end
