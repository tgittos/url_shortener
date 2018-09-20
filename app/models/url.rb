class Url < ApplicationRecord
    validates :long_url, presence: true
    validate :long_url_must_be_valid

    scope :active, ->() { where(active: true) }

    after_create do |url|
        url.admin_slug ||= slug + RandomString.generate
        url.save
    end

    def slug
        return nil if id.nil?
        Base52Encoder.encode(id)
    end

    def self.find_by_slug(slug)
        id = Base52Encoder.decode(slug)
        find_by_id(id)
    end

    private

    def long_url_must_be_valid
        if !UrlValidator.validate(long_url)
            errors.add(:long_url, 'must be a valid url')
        end
    end
end
