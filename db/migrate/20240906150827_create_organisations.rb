class CreateOrganisations < ActiveRecord::Migration[7.2]
  def change
    create_table :organisations do |t|
      t.string :subdomain
      t.string :name
      t.belongs_to :owner, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
