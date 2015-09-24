module HiThere
  module ApplicationHelper
    def nav_link_class(link_name)
      "active" if controller_name == link_name.to_s
    end
  end
end
