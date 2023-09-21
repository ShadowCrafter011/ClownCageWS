module ActionsHelper
    def alert_selections data
        data = JSON.parse data
        output = [["None", 0]]
        data["alert"].each_with_index do |alert, i|
            output.append [alert, "alert_#{i}"]
        end
        data["confirm"].each_with_index do |confirm, i|
            output.append [confirm, "confirm_#{i}"]
        end
        data["prompt"].each_with_index do |prompt, i|
            output.append [prompt["message"], "prompt_#{i}"]
        end
        output
    end

    def open_tab_selections data
        data = JSON.parse data
        data.map {|url| [url, url]}
    end
end
