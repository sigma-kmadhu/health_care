class CreateDaywiseInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :daywise_infos do |t|
      t.date :t_date
      t.string :status
      t.references :patient, index: true, foreign_key: true

      t.timestamps
    end
  end
end
