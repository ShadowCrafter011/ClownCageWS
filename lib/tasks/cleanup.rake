namespace :cleanup do
    desc "Clean dispatches table"
    task dispatches: :environment do
        cleaned = 0
        Dispatch.all.each do |d|
            if Time.now - d.created_at > 30.minutes
                d.destroy
                cleaned += 1
            end
        end
        puts "Cleaned up #{cleaned} dispatch#{"es" unless cleaned == 1}"
    end
end
