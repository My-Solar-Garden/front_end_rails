class UserFacade
  def self.update_email(id, email)
    UserService.update_email(id, email)
  end

  def self.delete_user(id)
    UserService.delete_user(id)
  end
end
