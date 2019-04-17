class CreateJoinTableCompanyLocation < ActiveRecord::Migration[5.2]
  def change
    create_join_table :companies, :locations, table_name: :company_locations do |t|
      t.index [:company_id, :location_id]
      t.index [:location_id, :company_id]
    end
  end
end
