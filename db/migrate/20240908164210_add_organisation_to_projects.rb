class AddOrganisationToProjects < ActiveRecord::Migration[7.2]
  def change
    add_reference :projects, :organisation, null: false, foreign_key: true
    add_reference :projects, :team, null: true, foreign_key: true
    remove_reference :projects, :user, null: true, foreign_key: true
  end
end
