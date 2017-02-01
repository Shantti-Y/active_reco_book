class User < ApplicationRecord
   has_many :posts, dependent: :destroy

   before_create :generate_activation

   attr_accessor :remember_token, :activate_token, :password_reset_token

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[\w\d\-.]+\.[A-z]+\z/

   validates :name, presence: true,
                    length: { maximum: 20 }
   validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
   validates :employee_number, presence: true,
                               length: { maximum: 8 }
   validates :division, presence: true,
                        length: { maximum: 50 }
   validates :gender, presence: true,
                      format: { with: /男|女/ }
   validates :started_at, presence: true
   validates :birthday, presence: true
   validates :employee, presence: true
   validates :password, presence: true,
                        length: { minimum: 8 },
                        allow_nil: true
   has_secure_password

   validate :file_valid?

   def remember
      self.remember_token = User.new_token
      self.update_attribute(:remember_digest, User.digest(self.remember_token))
   end

   def forget
      self.update_attribute(:remember_digest, nil)
   end

   def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
   end

   def User.new_token
      SecureRandom.urlsafe_base64
   end

   def authenticated?(attribute, token)
      field = self.send("#{attribute}_digest")
      return false if field.nil?
      BCrypt::Password.new(field).is_password?(token)
   end

   def send_activation_mail
      UserMailer.account_activation(self).deliver_now
   end

   def send_password_reset_mail
      UserMailer.password_reset(self).deliver_now
   end

   def password_expired?
      if self.password_reset? && self.password_reset_sent_at + 2.weeks <= Time.now
         return true
      else
         return false
      end
   end

   def uploaded_thumbnail=(thumbnail_field)
     self.thumbnail_ctype = thumbnail_field.content_type
     self.thumbnail = thumbnail_field.read
   end

   private
      def generate_activation
         self.activate_token = User.new_token
         self.activate_digest = User.digest(self.activate_token)
      end

      def file_valid?
        ps = ["image/jpeg", "image/jpg", "image/gif", "image/png"]
        errors.add(:thumbnail, 'is not an image file') if !self.thumbnail.nil? && !ps.include?(self.thumbnail_ctype)
      end

end
