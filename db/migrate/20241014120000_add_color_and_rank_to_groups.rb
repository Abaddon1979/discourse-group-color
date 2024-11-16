# discourse-group-color/db/migrate/20241014120000_add_color_and_rank_to_groups.rb

class AddColorAndRankToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :color, :string, default: ''
    add_column :groups, :rank, :integer, default: 9999
  end
end