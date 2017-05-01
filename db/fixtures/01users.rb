
User.seed do |s|
   s.id                     = 1
   s.name                   = "例得　升男"
   s.employee_number        = 12345678
   s.division               = "技術部開発課"
   s.gender                 = "男"
   s.started_at             = Date.new(2015, 4, 1)
   s.birthday               = Date.new(1992, 1, 1)
   s.employee               = true
   s.password_digest        = User.digest('password')
   s.activated              = true
   s.password_reset         = false
   s.password_reset_sent_at = Time.now
end

User.seed do |s|
   s.id                     = 2
   s.name                   = "例里　久子"
   s.employee_number        = 23456789
   s.division               = "営業部企画課"
   s.gender                 = "女"
   s.started_at             = Date.new(2013, 4, 1)
   s.birthday               = Date.new(1990, 9, 12)
   s.employee               = true
   s.password_digest        = User.digest('password')
   s.activated              = true
   s.password_reset         = false
   s.password_reset_sent_at = Time.now
end

# HR person
User.seed do |s|
   s.id                     = 3
   s.name                   = "例部　純太"
   s.employee_number        = 34567890
   s.division               = "人事部"
   s.gender                 = "男"
   s.started_at             = Date.new(2008, 4, 1)
   s.birthday               = Date.new(1980, 5, 21)
   s.employee               = false
   s.password_digest        = User.digest('password')
   s.activated              = true
   s.password_reset         = false
   s.password_reset_sent_at = Time.now
end
