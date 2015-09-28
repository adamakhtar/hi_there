HiThere.app_domain = "example.com"
HiThere.from = 'Admin'
HiThere.reply_to = 'your_email@example.com'

HiThere.authorization_method = :can_manage_hi_there?
HiThere.user_class = "User" # must be a string
HiThere.per_page = 20
HiThere.redirect_unauthorized_path = '/'
HiThere.current_user_method = :current_user

