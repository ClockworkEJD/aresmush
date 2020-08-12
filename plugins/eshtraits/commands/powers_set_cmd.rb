module AresMUSH
    module ESHTraits
        class SetPowersCmd
            include CommandHandler

            attr_accessor :name, :powers

            def parse_args
                if (cmd.args =~ /.+=.+/)
                    args = cmd.parse_args(ArgParser.arg1_equals_arg2)

                    self.name = titlecase_arg(args.arg1)
                    self.powers = args.arg2

                else

                    self.name = enactor_name
                    self.powers = cmd.args
                end
            end

            def required_args
                [ self.name, self.powers ]
            end

            def handle 
                ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
                    if (enactor.name == model.name && !Chargen.check_chargen_locked(enactor))
                        model.update(powers: self.powers)
                        client.emit_success t('eshtraits.powers_set')
                    elsif (Chargen.can_approve?(enactor))
                        model.update(powers: self.powers)
                        client.emit_success t('eshtraits.powers_set')
                    else
                        client.emit_failure t('dispatcher.not_allowed')
                    end
                end
            end
        end
    end
end

