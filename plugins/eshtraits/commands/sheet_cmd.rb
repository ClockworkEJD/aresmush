module AresMUSH
    module ESHTraits
        class SheetCmd
            include CommandHandler

            attr_accessor :name, :powers, :skills, :advantages, :flaws 

            def parse_args
                self.name = cmd.args || enactor_name
            end

            def handle 
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    template = BorderedDisplayTemplate.new model.powers, "#{model.name}'s Powers"
                    client.emit template.render
                end
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    template = BorderedDisplayTemplate.new model.skills, "#{model.name}'s Skills"
                    client.emit template.render
                end
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    template = BorderedDisplayTemplate.new model.advantages, "#{model.name}'s Advantages"
                    client.emit template.render
                end
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    template = BorderedDisplayTemplate.new model.flaws, "#{model.name}'s Flaws"
                    client.emit template.render
                end               
            end
        end
    end
end