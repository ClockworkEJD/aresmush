module AresMUSH
    module ESHTraits
        class PowersCmd
            include CommandHandler

            attr_accessor :name, :powers 

            def parse_args
                self.name = cmd.args || enactor_name
            end

            def handle 
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    template = BorderedDisplayTemplate.new model.powers, "#{model.name}'s Powers"
                    client.emit template.render
                end
            end
        end
    end
end