namespace :hi_there do
  namespace :emails do
    desc "Deliver next installment of emails to subscribers"
    task :deliver => :environment do
      operation = HiThere::FulfillSubscriptions.new
      operation.perform
    end 
  end
end