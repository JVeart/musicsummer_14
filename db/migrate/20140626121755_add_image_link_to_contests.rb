class AddImageLinkToContests < ActiveRecord::Migration
  def change
    add_column :reports, :image_link, :string
  end
end
