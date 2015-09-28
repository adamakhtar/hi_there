HiThere.app_domain = "example.com"
HiThere.user_class = "<%= user_class %>" # must be a string
HiThere.authorization_method = :can_manage_hi_there?
HiThere.from = 'Admin'
HiThere.per_page = 20
HiThere.redirect_unauthorized_path = '/'
HiThere.reply_to = 'your_email@example.com'
HiThere.current_user_method = :<%= current_user_method %>