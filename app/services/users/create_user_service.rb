# frozen_string_literal: true
module Users
  class CreateUserService
    Result = Struct.new(:success?, :user, :errors, :status)

    def initialize(user_params)
      @user_params = user_params
    end

    def call
      user = Taskflow::Model::User.new(@user_params.merge(active: true))
      user.save!
      Result.new(true, user, nil, :created)
    rescue ActiveRecord::RecordInvalid => e
      Result.new(false, nil, e.record.errors.full_messages, :unprocessable_entity)
    end

  end
end
