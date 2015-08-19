ActiveAdmin.register JobCategory do
  permit_params :name

  index do
    selectable_column
    column :name
    column 'No. of Job under categories' do |cat|
      cat.jobs.count
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row 'No. of Job under this category' do |cat|
        cat.jobs.count
      end
      row 'Job under this category' do |cat|
        cat.jobs.map.each do |job|
          link_to(job.title, job_path(job))
        end.join(', ').html_safe
      end
      row :created_at
      row :updated_at
    end
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.actions
    end
  end


end
