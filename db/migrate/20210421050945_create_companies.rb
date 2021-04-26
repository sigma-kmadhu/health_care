class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.boolean :is_updated, default: false

      t.timestamps
    end
  end
end
