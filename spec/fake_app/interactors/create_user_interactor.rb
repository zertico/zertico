class CreateUserInteractor < Zertico::Interactor
  def perform(attributes, objects)
    @user = User.create(attributes)
  end

  def rollback
    @user.destroy
  end
end