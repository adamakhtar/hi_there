# The name of your user class e.g. User, Member, Admin etc
# MUST be a string
HiThere.user_class = "<%= user_class %>" 

# The name of an instance method you have defined on 
# your "user" model which authorizes a user to access
# the hi_there dashboard.
HiThere.authorization_method = :can_manage_hi_there?

# The name of the method you used in your app to retrieve the
# current user. If you use devise then this will be current_user
HiThere.current_user_method = :<%= current_user_method %>

# Where to redirect users if they are unauthorized
HiThere.redirect_unauthorized_path = '/'

# The dashboard will have a link back to somewhere in your 
# app for convenience. You can set it here. 
# Note you will have to write it out yourself as path helpers
# are not available in initializers.
# e.g. /admin 
HiThere.return_to_main_app_path = '/'


# The domain of your app e.g. "myfabapp.com", "app.myfabapp.com" etc.
# Used to construct the confirm your email link.
HiThere.app_domain = "example.com"

# The reply to and from address to use for system notifications 
# such as "please confirm your email". 
#
# Note: This is not used for your
# course emails. You can set reply to and from information
# via the dashboard
HiThere.reply_to = 'your_email@example.com'
HiThere.from = 'Admin'

# Pagination - how many results to show per page
HiThere.per_page = 20
