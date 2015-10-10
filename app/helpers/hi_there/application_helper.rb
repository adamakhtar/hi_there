module HiThere
  module ApplicationHelper
    def body_classes
      "hi_there_#{controller_name} hi_there_#{controller_name}_#{action_name}"
    end

    def nav_link_class(link_name)
      "active" if controller_name == link_name.to_s
    end
  end
end
