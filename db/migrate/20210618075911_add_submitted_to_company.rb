class AddSubmittedToCompany < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :submitted, :boolean, default: false
  end
end
