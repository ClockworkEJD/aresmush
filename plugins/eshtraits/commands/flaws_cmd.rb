module AresMUSH
    module ESHTraits
        class FlawsCmd
            include CommandHandler

            attr_accessor :name, :flaws 

            def parse_args
                self.name = cmd.args || enactor_name
            end

            def handle 
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    template = BorderedDisplayTemplate.new model.flaws, "#{model.name}'s Flaws"
                    client.emit template.render
                end
            end
        end
    end
end