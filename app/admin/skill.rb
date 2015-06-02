ActiveAdmin.register Skill do
  permit_params :name

  index do
    selectable_column
    column :name
    # column 'Skill under categories' do |cat|
    #   cat.organization_categories.collect { |x| x.name }.join(', ')
    # end
    actions
  end

  show do
    attributes_table do
      row :name
      # row 'Skill under categories' do |cat|
      #   cat.organization_categories.collect { |x| x.name }.join(', ')
      # end
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
