class AddApiSourceToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :api_source, :string
  end
end
