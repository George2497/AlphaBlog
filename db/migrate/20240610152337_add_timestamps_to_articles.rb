class AddTimestampsToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :create_at, :datetime
    add_column :articles, :update_at, :datetime
  end
end
