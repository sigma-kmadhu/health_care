class CreateLocServiceDds < ActiveRecord::Migration[6.1]
  def change
    create_table :loc_service_dds do |t|
      t.string :loc
      t.string :service

      t.timestamps
    end
  end
end
