class ChangeDataTypePerksDescription < ActiveRecord::Migration
  def change
    change_column('perks', 'description', 'text')
    #             [Table name] [Column Name] [Type name]
  end
end
