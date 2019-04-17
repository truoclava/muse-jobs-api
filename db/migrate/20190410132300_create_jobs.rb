class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.integer :level
      t.boolean :published, default: false
      t.datetime :published_at
      t.datetime :unpublished_at
      t.integer :company_id
    end
  end
end
