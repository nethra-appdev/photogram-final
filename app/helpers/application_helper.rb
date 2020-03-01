module ApplicationHelper
 def human_boolean(boolean)
    boolean ? 'Yes' : 'No'
end

def displayusername
  the_id = session.fetch(:user_id)
    @current_user = User.where({ :id => the_id }).at(0).username
end
end
