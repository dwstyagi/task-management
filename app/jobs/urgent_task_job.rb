class UrgentTaskJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    ActsAsTenant.without_tenant do
      urgent_tasks = Task.urgent
      urgent_tasks.find_each do |task|
        ActsAsTenant.with_tenant(task.organisation) do
          UrgentTaskNotifier.with(record: task).deliver(task.assignee)
        end
      end
    end
  end
end
