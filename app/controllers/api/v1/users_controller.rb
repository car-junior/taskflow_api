module Api
  module V1
    class UsersController < Api::BaseController
      def index
        @users = Users::ListUsersService.new(params).call
      end
    end
  end
end
