class UsersPermittedParams < Zertico::PermittedParams
  def create
    params.require(:user).permit(:name)
  end

  def update
    params.require(:user).permit(:id)
  end
end