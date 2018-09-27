class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summaty, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
    validate :is_clickbait?

    CLICKBAIT_PATTERNS = [
        /Won't Believe/i,
        /Secret/i,
        /Top [0-9]*/i,
        /Guess/i
        ]

    def is_clickbait?
       if CLICKBAIT_PATTERNS.none? { |clickbait| clickbait.match title }
         errors.add(:title, "must be clickbait-y")
       end
    end
end
