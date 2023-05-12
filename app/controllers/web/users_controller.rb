class Web::UsersController < Web::ApplicationController
  respond_to :html, :json
  before_action :find_and_authorize_user, except: %i[new create index]

  def index
    authorize User

    @q = policy_scope(User).ransack(params[:q])
    @pagy, @users = pagy(@q.result)
  end

  def show
    @user.password = nil
    respond_with @user
  end

  def new
    authorize User

    @user = User.new
    respond_with @user
  end

  def edit
  end

  def create
    authorize User

    @user = User.new(user_params)
    @user.save
    flash[:notice] = 'Пользователь успешно создан'
    respond_with @user
  end

  def update
    if @user.update(user_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @user.discard
    flash[:notice] = 'Пользователь удалён'
    redirect_to users_path
  end

  def lock
    @user.lock_access!(send_instructions: false)
    flash[:notice] = 'Пользователь заблокирован'
    respond_with @user
  end

  def unlock
    @user.unlock_access!
    flash[:notice] = 'Пользователь разблокирован'
    respond_with @user
  end

  def restore
    @user.undiscard!
    flash[:notice] = 'Пользователь восстановлен'
    respond_with @user
  end

  private

  def find_and_authorize_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params[:user].delete(:password) if params[:user][:password].blank?
    attributes = %i[username email password role]

    if params[:action] == 'create'
      params[:user].delete(:password_confirmation) if params[:user][:password].blank?
      attributes.push(:password_confirmation)
    end

    params.require(:user).permit(attributes)
  end
end
