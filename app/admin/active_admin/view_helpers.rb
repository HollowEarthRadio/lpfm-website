module ActiveAdmin::ViewHelpers
  def all_users_with_dj_role(program)
    array = Array.new
    Role.find_by_name("dj").users.each do |user|
      array << [ :"#{user.dj_name}", user.id, { checked: program.users.include?(user) }]
    end
    array
  end
end
