module TasksHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'create'
      confirm_tasks_path
    elsif action_name == 'edit'
      task_path
    end
  end

  def button_text
    if action_name == "new"
      "追加する"
    elsif action_name == "edit"
      "編集する"
    end
  end
end
