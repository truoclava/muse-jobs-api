class CreateJoinTableJobLocation < ActiveRecord::Migration[5.2]
  def change
    create_join_table :jobs, :locations, table_name: :job_locations do |t|
      t.index [:job_id, :location_id]
      t.index [:location_id, :job_id]
    end
  end
end
