ActiveAdmin.register OrganizationCategory do

  permit_params :name


  index do
    selectable_column
    column :name
    # column 'Companies in this category' do |cat|
    #   cat.companies.count
    # end
    actions
  end

  show do
    attributes_table do
      row :name
      # row Companies in this category' do |cat|
      #   cat.companies.count
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
