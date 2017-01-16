class User < ApplicationRecord
=begin
   name, email, employee_number, devision, gender,
   started_at, birthday, employee
=end

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
end
