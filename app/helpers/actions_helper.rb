# frozen_string_literal: true

module ActionsHelper
  def display_result(action)
    return trans("locations.#{action.location.index}.actions.#{action.index}.result.failure") unless action.necessary

    result = action.result || "success"
    trans("locations.#{action.location.index}.actions.#{action.index}.result.#{result}")
  end
end