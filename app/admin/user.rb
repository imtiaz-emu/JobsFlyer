ActiveAdmin.register User do
  config.clear_action_items!
  actions :index
  permit_params :email
  filter :email, as: :string

  member_action :access do
    @profile = User.find(params[:id]).profile
    @profile.update_column(:can_post, true)
    redirect_to :back
  end

  member_action :deny do
    @profile = User.find(params[:id]).profile
    @profile.update_column(:can_post, false)
    redirect_to :back
  end

  index do
    selectable_column
    column :email
    column 'user in companies' do |user|
      user.companies.collect { |x| x.name }.join(', ')
    end

    actions do |user|
      link_to('access to post', access_admin_user_path(user))
    end

    actions do |user|
      link_to('limit to post', deny_admin_user_path(user))
    end
  end

end
