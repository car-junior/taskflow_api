module Api
  module V1
    class UsersController < Api::BaseController
      before_action :set_user, only: [:show, :update]

      def index
        @users = Users::ListUserService.new(params).call
      end

      def create
        result = Users::CreateUserService.new(user_params).call
        @user = result.user
        if result.success?
          render :show, status: :created
        else
          render json: { errors: result.errors }, status: result.status
        end
      end

      def update
        result = Users::UpdateUserService.new(@user, update_user_params).call
        @user = result.user
        if result.success?
          render :show, status: result.status
        else
          render json: { errors: result.errors }, status: result.status
        end
      end

      def show; end

      private

      def set_user
        @user = Taskflow::Model::User.find(params[:id])
      end

      def user_params
        params.permit(:name, :last_name, :email, :password, :cpf, :phone_number)
      end

      def update_user_params
        params.require(:user).permit(:id, :last_name, :email, :phone_number)
      end
    end
  end
end
