class AddApiSourceToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :api_source, :string
  end
end
