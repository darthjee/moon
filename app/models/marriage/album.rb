class Marriage::Album < ActiveRecord::Base
  belongs_to :marriage
  has_many :pictures

  scope :displayable, proc { where.not(status: :cancelled) }
  scope :from_album, proc { |album_id| where(album_id: album_id) }
  scope :top_album, proc { where(album_id: nil) }
  default_scope { displayable }

  def as_json(*args)
    options = args.extract_options!
    options = {
      except: [:created_at, :updated_at]
    }.merge(options)

    super(*args, options).merge(
      snap_url: pictures.first.try(:snap_url)
    )
  end
end

