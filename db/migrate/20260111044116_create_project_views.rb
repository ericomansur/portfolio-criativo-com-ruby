class CreateProjectViews < ActiveRecord::Migration[8.1]
  def change
    create_table :project_views do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :ip_address

      t.timestamps
    end
  end
end
