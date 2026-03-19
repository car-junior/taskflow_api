# frozen_string_literal: true

module Taskflow
  module Concerns
    module User
      module Methods
        extend ActiveSupport::Concern

        def masked_cpf
          return nil if cpf.blank?
          "***.***.***-#{cpf.last(2)}"
        end
      end
    end
  end
end
