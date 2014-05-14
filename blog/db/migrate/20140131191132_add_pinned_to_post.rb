class AddPinnedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :pinned, :boolean
  end
end
