module EventHelper
  def action_of(event)
    case event
    when Events::EntityCreated
      "Created"
    when Events::EntityEdited
      "Edited"
    when Events::EntityDeleted
      "Deleted"
    else
      "Unknown action"
    end
  end
end
