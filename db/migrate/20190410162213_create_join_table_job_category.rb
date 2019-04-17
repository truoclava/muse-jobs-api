class CreateJoinTableJobCategory < ActiveRecord::Migration[5.2]
  def change
    create_join_table :jobs, :categories, table_name: :job_categories do |t|
      t.index [:job_id, :category_id]
      t.index [:category_id, :job_id]
    end
  end
end
