class ProgramImage < ActiveRecord::Base
  belongs_to :program
  validates :attachment, attachment_presence: true
end
