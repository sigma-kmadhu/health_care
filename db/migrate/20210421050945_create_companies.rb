class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.datetime :last_updated_at

      t.timestamps
    end
  end
end
