class UsersPermittedParams < Zertico::PermittedParams
  def create
    params.require(:user).permit(:first_name)
  end

  def update
    params.require(:user).permit(:last_name)
  end
end