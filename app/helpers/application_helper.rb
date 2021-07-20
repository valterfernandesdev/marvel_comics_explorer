module ApplicationHelper
  def not_liked_comic?(comic_id, current_user_id)
    FavouritComic.find_by(user_id: current_user_id, comic_id: comic_id).nil?
  end

  def show_next_btn?(data)
    (data["offset"].to_i + 20) < data["total"].to_i
  end

  def show_previous_btn?(data)
    data["offset"].to_i >= 20
  end

  def next_offset_calculator(data)
    return 20 if data["offset"].to_i.zero?

    data["offset"].to_i + 20
  end

  def back_offset_calculator(data)
    return 0 if data["offset"].to_i.zero?

    data["offset"].to_i - 20
  end
end
