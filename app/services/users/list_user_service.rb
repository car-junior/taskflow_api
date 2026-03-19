# frozen_string_literal: true

module Users
  class ListUserService < BaseService
    DEFAULT_PER_PAGE = 10
    ALLOWED_ORDER_COLUMNS = %w[name email created_at].freeze

    def initialize(params)
      @params = params
    end

    def call
      users = Taskflow::Model::User.all
      users = apply_filters(users)
      users = apply_order(users)
      apply_pagination(users)
    end

    private

    def apply_filters(scope)
      scope = scope.where(active: @params[:active]) if @params[:active].present?
      if @params[:query].present?
        query = "%#{@params[:query]}%"
        scope = scope.where("name ILIKE :query OR last_name ILIKE :query OR email ILIKE :query", query: query)
      end
      scope
    end

    def apply_order(scope)
      column = ALLOWED_ORDER_COLUMNS.include?(@params[:order_by]) ? @params[:order_by] : "created_at"
      direction = @params[:direction] == "asc" ? :asc : :desc
      scope.order(column => direction)
    end

    def apply_pagination(scope)
      per_page = @params[:per_page].present? ? @params[:per_page].to_i.clamp(1, 100) : DEFAULT_PER_PAGE
      scope.page(@params[:page]).per(per_page)
    end
  end

end
