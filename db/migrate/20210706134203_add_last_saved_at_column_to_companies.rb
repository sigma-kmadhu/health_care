class AddLastSavedAtColumnToCompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :last_saved_at, :datetime
  end
end
