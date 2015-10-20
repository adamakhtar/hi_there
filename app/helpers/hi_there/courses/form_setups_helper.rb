module HiThere
  module Courses
    module FormSetupsHelper
      def snippet_for_view
        # TOFIX For some reason we need a newline after herdoc otherwise
        # indentation is broken when rendered.
        string = <<-DOC.strip_heredoc
        <% if @course and @course.opened? %>
          <h2><%= @course.title %></h2>
          <p><%= @course.description %></p>
          <%= form_tag hi_there.subscriptions_path do |f| %>
            <%= text_field_tag :secret_field %>
            <%= text_field_tag :email %>
            <%= hidden_field_tag :course_id, @course.id %>
            <%= submit_tag "Sign up" %>
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