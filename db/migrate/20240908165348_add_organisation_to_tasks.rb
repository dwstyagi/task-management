class AddOrganisationToTasks < ActiveRecord::Migration[7.2]
  def change
    add_reference :tasks, :organisation, null: false, foreign_key: true
  end
end
