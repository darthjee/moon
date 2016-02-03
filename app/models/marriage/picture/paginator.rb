class Marriage::Picture::Paginator < Utils::Paginator

  private

  def ordered_list
    paginated_list.order(:id)
  end

  def key
    :pictures
  end
end
