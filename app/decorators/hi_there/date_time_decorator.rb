module HiThere
  class DateTimeDecorator < SimpleDelegator
    def before?(time_str)
      ("00:00"...time_str).cover? self.strftime("%H:%M")
    end

    def after?(time_str)
      !before?(time_str)
    end

    # returns a new time which is advanced to the given time 
    # and moves to the next day if necessary.
    def wind_forward_to(time_str)
      hour = time_str[0..1]
      min  = time_str[3..4]
      adjusted = self.change(hour: hour.to_i, min: min.to_i)
      adjusted = adjusted + 1.day if self.after?(time_str)
      adjusted
    end
  end
end