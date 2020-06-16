module AresMUSH
    module Custom
        class PlotcheckCmd
            include CommandHandler

            def check_can_view
                return nil if enactor.has_permission?("view_bgs")
                return "You are not allowed to use this command."
            end

            def handle 
                scene_info = Scenes.recent_scenes.map { |s| "#{s.id} - #{s.title}.ljust(30) #{s.plot ? s.plot.title : "---" }.rjust(30)" }.join "\n" 
                client.emit "#{scene_info}"
            end
        end
    end
end