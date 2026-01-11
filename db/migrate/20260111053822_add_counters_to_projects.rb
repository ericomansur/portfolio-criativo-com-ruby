class AddCountersToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :likes_count, :integer
    add_column :projects, :comments_count, :integer
    add_column :projects, :views_count, :integer
  end
end
