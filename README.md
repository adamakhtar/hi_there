# HiThere

## Headsup!

This gem is not ready yet. I'm simply pushing to github as I progress for backup reasons. Check back soon though! Weeks not months.

**Headsup:** Requires Posgres or MySQl

## What is ths HiThere?

HiThere is a rails engine to create automated email courses - courses comprised of several emails you have written on some topic which are then released on a schedule you define to anyone who opts in to it. 

This gem isn't a replacement for the commercial solutions such as www.getdrip.com or www.mailchimp.com but rather a simple free tool you can use if you don't require the kitchen sink.

Here's what you can do with this engine

* create multiple courses comprised of many emails.
* define a schedule of how the emails should be released.
* have visitors opt in
* require opt ins to confirm their email address before starting the course
* open and close a course for further opt ins.
* allow subscribers to unsubscribe at any time
* view all subcribers for a given course
* download your subscribers as csv 

Here's what you can't do:

* transform email links into utm trackable links (...yet)
* track open rates (...yet)
* make changes to a coruse once underway (you will have to create a new one and sunset the old one)
* do any AB Testing 
* send "fancy" responsive newsletters - only text with basic formatting

## Setting up

First you will need to have [configured your rails app](http://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration) for email delivery. You will probably want to use a service like mailgun or postman to send your emails. 

```ruby
gem 'hi_there', github: 'robodisco/hi_there'

```sh
bundle install
rails g hi_there:install
```

This will create a hi_there initializer file which **you will definately need to edit**. It will look something like this. See the initializer for more information regarding each setting.

```ruby
HiThere.user_class = "User" 
HiThere.authorization_method = :can_manage_hi_there?
HiThere.current_user_method = :current_user
HiThere.redirect_unauthorized_path = '/'
HiThere.app_domain = "example.com"
HiThere.reply_to = 'your_email@example.com'
HiThere.from = 'Admin'
HiThere.per_page = 20
```

## Creating a course and it's emails

Once setup you can visit your hi_there dashboard at /hi_there/

Simply create a coures, give it a title and a name for internal use. Then you can start creating your emails and setting their release schedule once someone subscribes. 

## Setting up your optin form

Once you've setup your course you will want to show an optin form somewhere back in your own app to collect emails. HiThere leaves this to you so you can code it up exactly how you want it to look. 

As an example let's imagine you have a landing_page action in one of your controllers. First you need to load your course on 'The joys of lock picking' which you named 'lock_picking_course' and build a subscription record.

```ruby
class HomeController < ApplicationController          
  def landing_page
    @course = HiThere::Course.where(name: 'lock_picking_course').take
    @subscription = @course.subscriptions.build if @course
  end
end
```

Then in your landing_page.html.erb view

```erb
<% if @course and @course.opened? %>
  <%= @course.title %>
  <%= simple_form_for @subscription, url: hi_there.subscriptions_path do |f| %>
    <%= text_field_tag :secret_field %>
    <%= f.input :email %>
    <%= f.input :course_id, as: :hidden %>
    <%= f.submit "Sign up" %>
  <% end %>
<% end %>
```

And in your stylesheets 

```css
input#secret_field {
    position: absolute;
    left: -10000px;
}
```

**Hey!** What's that css and "secret_field" for? 

The secret_field is a honey pot for spammy bots who like to crawl web pages and submit spammy comments on forms. If they fill in this field and submit the form, hi_there will ignore the submission and won't create a subscription helping you preserve a good rating with your email delivery provider. Of course left like so the field will be visible to your visitors. So you need to add the css above to hide it from humans. Bots however are are usually blind to such css trickery, 

## Delivering emails

Schedule the following rake task to run on a regular basis i.e. every hour.

rake hi_there:emails:deliver

This task will look for subscriptions which are due their next installment and then schedule when their next installment occurs.

## Styling

To prevent your existing styles creeping into HiThere and vica versa, the gem explictly loads a stylesheet in its applciation layout by the name of /hi-there.css rather than the usual appication.css your own layouts use.

You can find this stylesheet in `app/vendor/assets/stylesheets` where you can style the engine to your hearts content. 

**What? You'd rather it be styled for you?**

Well in that case you should also add this to your gemfile:

```ruby
gem 'hi_there_bootstrap', github: 'robodisco/hi_there_bootstrap'
```

then in the hi-there.scss file mentioned above add the following

```scss
@import "hi-there-bootstrap";
```

Which will use bootstrap via the bootstrap-sass gem to "jazz" things up a bit. 

You can add further stylings after the `@import` decalaration if you require further customization. 

## Customizing sent emails

Subscribers will receive two email types:

1. "A thank you for signing up. Please confirm your email" email.
2. The scheduled emails from your course with an unsubscribe link at the bottom.

If you want to customize these emails you can copy the mailer views they use to your app via:

```sh
rails g hi_there:mailer_views
```


