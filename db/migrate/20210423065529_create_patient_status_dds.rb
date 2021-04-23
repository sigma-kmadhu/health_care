class CreatePatientStatusDds < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_status_dds do |t|
      t.string :name

      t.timestamps
    end
  end
end
