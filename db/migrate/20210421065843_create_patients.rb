class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :insurance_provider
      t.date :dob
      t.string :therapist
      t.date :admit_date
      t.string :loc
      t.references :company, index: true, foreign_key: true

      t.timestamps
    end
  end
end
