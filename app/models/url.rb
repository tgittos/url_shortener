class Url < ApplicationRecord
    validates :admin_slug, presence: true, uniqueness: true
    validates :user_slug, presence: true, uniqueness: true
    validates :long_url, presence: true
    validate :slugs_cannot_match

    private

    def slugs_cannot_match
        if admin_slug == user_slug
            errors.add(:base, 'admin_slug cannot be the same as user_slug')
        end
    end
end
