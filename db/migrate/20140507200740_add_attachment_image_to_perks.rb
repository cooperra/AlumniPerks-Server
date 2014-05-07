class AddAttachmentImageToPerks < ActiveRecord::Migration
  def self.up
    change_table :perks do |t|
      t.remove :timestamp, :image_updated_at
    end
    change_table :perks do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :perks, :image
    change_table :perks do |t|
      t.timestamp :image_updated_at
    end
  end
end
