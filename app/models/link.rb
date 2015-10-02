class Link < ActiveRecord::Base
  belongs_to :movie, touch: true

  scope :latest, -> { order('created_at') }

end
