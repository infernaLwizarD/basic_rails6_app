module UserRansack
  extend ActiveSupport::Concern

  included do
    ransack_alias :search, :username_or_email
  end

  class_methods do
    def ransackable_attributes(_auth_object = nil)
      %w[search id email username]
    end

    def ransackable_associations(_auth_object = nil)
      []
    end
  end
end
