module ResumeSearchHelper

  def already_saved(email)
    return current_user.saved_resumes.find_by_job_seeker_email(email).present?
  end

  def find_saved_resume(email)
    current_user.saved_resumes.find_by_job_seeker_email(email).id
  end

end
