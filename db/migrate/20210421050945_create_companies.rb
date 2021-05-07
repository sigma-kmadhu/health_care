class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies, id: false do |t|
      t.primary_key :actual_company_id
      t.string :name
      t.datetime :last_updated_at

      t.timestamps
    end
  end
end
