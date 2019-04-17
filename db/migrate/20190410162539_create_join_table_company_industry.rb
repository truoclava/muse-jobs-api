class CreateJoinTableCompanyIndustry < ActiveRecord::Migration[5.2]
  def change
    create_join_table :companies, :industries, table_name: :company_industries do |t|
      t.index [:company_id, :industry_id]
      t.index [:industry_id, :company_id]
    end
  end
end
