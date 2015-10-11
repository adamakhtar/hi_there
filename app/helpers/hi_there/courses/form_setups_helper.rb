module HiThere
  module Courses
    module FormSetupsHelper
      def snippet_for_view
        # TOFIX For some reason we need a newline after herdoc otherwise
        # indentation is broken when rendered.
        string = <<-DOC.strip_heredoc
        
        <h1>My home page</h1>
        <% if @course and @course.opened? %>
          <%= @course.title %>
          <%= simple_form_for @subscription, url: hi_there.subscriptions_path do |f| %>
            <%= hidden_field_tag :secret_field %>
            <%= f.input :email %>
            <%= f.input :course_id, as: :hidden %>
            <%= f.submit "Sign up" %>
          <% end %>
        <% end %>
        DOC
        string
      end

      def snippet_for_controller(course)
        # TOFIX For some reason we need a newline after herdoc otherwise
        # indentation is broken when rendered.
        string = <<-DOC.strip_heredoc

          class SomeController < ApplicationController          
            def some_action
              @course = HiThere::Course.where(name: '#{course.name}').take
              @subscription = @course.subscriptions.build if @course
            end
          end
        DOC
      end
    end
  end
end