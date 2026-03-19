# frozen_string_literal: true

module Users
  class UpdateUserService < BaseService
    Result = Struct.new(:success?, :user, :errors, :status)

    def initialize(user, update_user_params)
      @user = user
      @update_user_params = update_user_params
    end

    def call
      @user.update!(@update_user_params)
      Result.new(true, @user, nil, :ok)
    rescue ActiveRecord::RecordInvalid => e
      Result.new(false, nil, e.record.errors.full_messages, :unprocessable_entity)
    end

  end
end