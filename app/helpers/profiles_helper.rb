module ProfilesHelper
  def current_profile
    current_user.profile
  end

  def full_address(user)
    user.city + ', ' + Carmen::Country.coded(user.country).to_s
  end

end
