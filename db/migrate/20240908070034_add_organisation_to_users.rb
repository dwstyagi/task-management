class AddOrganisationToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :organisation_id, :integer
  end
end
