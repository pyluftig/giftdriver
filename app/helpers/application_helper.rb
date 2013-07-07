module ApplicationHelper
  def organizer?(drive)
    access = UsersWithAccess.where("user_id = ? AND drive_id = ?", current_user.id, drive.id).first
    true unless access.nil?
  end
end
