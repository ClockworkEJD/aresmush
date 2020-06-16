module AresMUSH
    module Custom
        class PlotcheckCmd
            include CommandHandler

            def check_can_view
                return nil if enactor.has_permission?("view_bgs")
                return "You are not allowed to use this command."
            end

            def handle 
                Scenes.recent_scenes.map { |s| "#{s.id} #{s.title} #{s.plot ? s.plot.title : "---"}".join "\n"
                client.emit
            end
        end
    end
end