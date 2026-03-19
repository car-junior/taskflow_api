# frozen_string_literal: true

module Users
  class DeleteLogicUserService < BaseService
    Result = Struct.new(:success?, :errors, :status)

    def initialize(user)
      @user = user
    end

    def call
      validate_exists_user_active
      @user.update!(active: false)
      Result.new(true, [], :no_content)
    rescue ValidationError => e
      Result.new(false, [e.message], :not_found)
    end

    private

    def validate_exists_user_active
      raise ValidationError, "Usuário não encontrado ou já inativo!" if @user.nil?
    end

  end
end