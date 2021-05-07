class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients, id: false do |t|
      t.primary_key :actual_patient_id
      t.string :name
      t.string :insurance_provider
      t.date :dob
      t.string :therapist
      t.date :admit_date
      t.string :loc
      t.string :missing_services

      # t.references :company, index: true, foreign_key: true
      t.references :company, references: :companies, null: false

      t.timestamps
    end
  end
end
