class Marriage::Album < ActiveRecord::Base
  belongs_to :marriage
  has_many :pictures

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

