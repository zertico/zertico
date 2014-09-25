class UsersPermittedParams < Zertico::PermittedParams
  def create
    params.require(:user).permit(:name)
  end

  def update
    params.permit(:id, :user => [:name])
  end
end