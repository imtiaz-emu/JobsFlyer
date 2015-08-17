module SavedLinksHelper
  def saved_link?(record)
    record.saved_links.where(:user_id => current_user.id).present?
  end

  def saved_link_id(record)
    link = record.saved_links.where(:user_id => current_user.id)
    link.present? ? link.first.id : nil
  end
end
