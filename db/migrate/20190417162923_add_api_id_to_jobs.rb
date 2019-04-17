class AddApiIdToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :api_id, :string
  end
end
