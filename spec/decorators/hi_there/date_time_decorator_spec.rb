require 'rails_helper'

module HiThere
  RSpec.describe DateTimeDecorator, type: :model do
    describe "#before?" do
      it "returns true when given time is after self" do
        midday = DateTime.parse("12:00")
        decorated = DateTimeDecorator.new(midday)

        expect(decorated.before?("14:00")).to be_truthy
      end
    end

    describe "#wind_forward_to?" do
      it "returns a time advanced to given time from self's time" do
        midday = DateTime.parse("12:00")
        decorated = DateTimeDecorator.new(midday)
        new_time = decorated.wind_forward_to("14:00")

        expect(new_time.strftime("%H:%M")).to eq "14:00"
      end

      it "advances to next day if given time already passed" do
        midday = DateTime.parse("12:00")
        decorated = DateTimeDecorator.new(midday)
        new_time = decorated.wind_forward_to("09:00")
        expect(new_time.strftime("%H:%M")).to eq "09:00"
        expect(new_time.day - midday.day).to eq 1
      end
    end
  end
end
