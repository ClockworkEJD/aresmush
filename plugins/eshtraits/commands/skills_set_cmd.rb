module AresMUSH
    module ESHTraits
        class SetSkillsCmd
            include CommandHandler

            attr_accessor :name, :skills 

            def parse_args
                if (cmd.args =~ /.+=.+/)
                    args = cmd.parse_args(ArgParser.arg1_equals_arg2)

                    self.name = titlecase_arg(args.arg1)
                    self.skills = args.arg2

                else

                    self.name = enactor_name
                    self.skills = cmd.args
                end
            end

            def required_args
                [ self.name, self.skills ]
            end

            def handle 
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    if (enactor.name == model.name && !Chargen.check_chargen_locked(enactor))
                        model.update(skills: self.skills)
                        client.emit_success t('eshtraits.skills_set')
                    elsif (Chargen.can_approve?(enactor))
                        model.update(skills: self.skills)
                        client.emit_success t('eshtraits.skills_set')
                    else
                        client.emit_failure t('dispatcher.not_allowed')
                    end
                end
            end
        end
    end
end

