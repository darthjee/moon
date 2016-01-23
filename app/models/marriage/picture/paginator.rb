class Marriage::Picture::Paginator < Utils::Paginator

  private

  def key
    :pictures
  end

  def list_json
    list.limit(per_page).offset(offset).as_json
  end
end
