class UrgentTaskJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    urgent_tasks = Task.urgent
    urgent_tasks.each do |task|
      UrgentTaskNotifier.with(record: task).deliver(task.project.user)
    end
  end
end
