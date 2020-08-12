module AresMUSH
    module ESHTraits
        class SkillsCmd
            include CommandHandler

            attr_accessor :name, :skills 

            def parse_args
                self.name = cmd.args || enactor_name
            end

            def handle 
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    template = BorderedDisplayTemplate.new model.skills, "#{model.name}'s Skills"
                    client.emit template.render
                end
            end
        end
    end
end