module HiThere
  module CoursesHelper
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