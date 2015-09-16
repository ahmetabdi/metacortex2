class Link < ActiveRecord::Base
  belongs_to :movie

  scope :latest, -> { order('created_at') }
end
