class CreatePerks < ActiveRecord::Migration
  def change
    create_table :perks do |t|
      t.primary_key :id
      t.string :company_name
      t.string :company_address
      t.string :company_phone
      t.string :description
      t.string :website
      t.string :coupon

      t.timestamps
    end
  end
end