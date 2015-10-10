module HiThere
  module ApplicationHelper
    def body_classes
      "hi_there_#{controller_name} hi_there_#{controller_name}_#{action_name}"
    end
  end
end
