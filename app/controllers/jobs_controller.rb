class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :has_subscription?, :only => [:create, :new]

  layout 'dashboard'
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs_tab = 'active'
    if params[:all].present?
      @jobs = Job.active_jobs.flatten.sort { |p1, p2| p2.deadline <=> p1.deadline }
    else
      @jobs = current_user.companies.collect { |company| company.jobs.active_jobs }.flatten.sort { |p1, p2| p2.deadline <=> p1.deadline }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @jobs_tab = 'active'
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        @job.update_job_skills_attributes(params[:job][:job_skills_attributes])
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        @job.update_job_skills_attributes(params[:job][:job_skills_attributes])
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @jobs_tab = 'active'
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:company_id, :title, :job_type, :salary_range, :is_negotiable, :payment_type, :apply_instructions, :deadline, :additional_requirement, :organization_category_id, :vacancies, :experience_range, :age_range, :job_location, :anywhere_in, :anywhere_place, :status, :payment_currency, :job_skills_attributes => [])
    end

    def has_subscription?
      active_subscriptions = current_user.companies.collect{|com| com.subscriptions.active_subscriptions}.flatten
      if active_subscriptions.count > 0
        active_subscriptions.each do |subscription|
          if subscription.normal_job > 0 || subscription.feature_job > 0
            return true
          end
        end
        redirect_to dashboard_path, flash: {:notice => "You've posted as many job as you subscribed. If you want to post a new job now then please re-subscribe!"}
      else
        redirect_to new_subscription_path, flash: {:error => "You've no active subscriptions. Please subscribe to post job!"}
      end
    end

end
