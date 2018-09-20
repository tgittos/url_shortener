class Url < ApplicationRecord
    validates :admin_slug, presence: true, uniqueness: true
    validates :user_slug, presence: true, uniqueness: true
    validates :long_url, presence: true
    validate :slugs_cannot_match
    validate :long_url_must_be_valid

    scope :active, ->() { where(active: true) }

    after_initialize do |url|
        url.admin_slug ||= RandomString.generate
        url.user_slug ||= RandomString.generate
    end

    private

    def slugs_cannot_match
        if admin_slug == user_slug
            errors.add(:base, 'admin_slug cannot be the same as user_slug')
        end
    end

    def long_url_must_be_valid
        if !UrlValidator.validate(long_url)
            errors.add(:long_url, 'must be a valid url')
        end
    end
end
