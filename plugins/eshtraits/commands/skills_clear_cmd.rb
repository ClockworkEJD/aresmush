module AresMUSH
    module ESHTraits
        class ClearSkillsCmd
            include CommandHandler

            attr_accessor :name, :skills

            def parse_args
                self.name = cmd.args || enactor_name
            end

            def required_args
                [ self.name ]
            end

            def handle 
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    if (enactor.name == model.name && !Chargen.check_chargen_locked(enactor))
                        model.update(skills: nil)
                        client.emit_success t('eshtraits.skills_cleared')
                    elsif (Chargen.can_approve?(enactor))
                        model.update(skills: nil)
                        client.emit_success t('eshtraits.skills_cleared')
                    else
                        client.emit_failure t('dispatcher.not_allowed')
                    end
                end
            end
        end
    end
end