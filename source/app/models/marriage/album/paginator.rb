# frozen_string_literal: true

class Marriage::Album::Paginator < Utils::Paginator
  private

  def ordered_list
    paginated_list.order(:id)
  end

  def key
    :albums
  end
end
