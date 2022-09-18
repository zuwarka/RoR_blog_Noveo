class User < ActiveRecord::Base
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  #has_secure_password
  has_many :articles, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }
  validates :email,
            presence: true,
            length: { maximum: 105 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }

  before_save { self.email = email.downcase }

end
# zuwarka: glorious@mail.ru, 12345
# olgerd: olgerd@mail.ru, 1111
# aman: aman@mail.ru, 1111
# saudi: saudi@mail.ru, 1111
# uranium: uran@mail.ru, 1111
# qwerty: qwerty@mail.ru, 1111