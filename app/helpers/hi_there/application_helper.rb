module HiThere
  module ApplicationHelper    
    def add_active_class_if(condition)
      "active" if condition
    end

    def body_classes
      "hi_there_#{controller_name} hi_there_#{controller_name}_#{action_name}"
    end

    def current_action?(controller:, action: nil)
      return false if controller_name != controller.to_s
      return false if (action.present? and action_name != action.to_s)
      return true
    end

    def link_to_with_state(link:, path:, is_disabled: false, is_active: false, is_dangerous: false, confirm_message: nil, **options)
      options.reverse_merge!({class: ""})
      if is_disabled
        path = 'javascript:void(0)'
        options[:class] += " disabled"        
      elsif is_active
        path = 'javascript:void(0)'
        options[:class] += " active"        
      end

      options[:data] = { confirm: confirm_message } if is_dangerous 

      link_to link, path, options
    end
  end
end
