module ResumeSearchHelper

  def already_saved(email)
    return current_user.saved_resumes.find_by_job_seeker_email(email).present?
  end

  def find_saved_resume(email)
    current_user.saved_resumes.find_by_job_seeker_email(email).id
  end

  def invited_jobs(job_ids)
    text = ""
    job_ids.each do |job_id|
      job = Job.find(job_id.to_i)
      text += "Invited to: " + job.title + "\n"
    end
    return text
  end

end
