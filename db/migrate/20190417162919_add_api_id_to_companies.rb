class AddApiIdToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :api_id, :string
  end
end
