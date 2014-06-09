class CreateUserInteractor < Zertico::Interactor
  def perform(attributes)
    @user = User.create(attributes)
  end

  def rollback
    @user.destroy
  end
end