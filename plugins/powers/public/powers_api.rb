module AresMUSH
    module Powers
        def self.save_char(char, chargen_data)
            powers = {}
            (chargen_data[:powers] || {}).each do |name, desc|
                powers[name.titlecase] = Website.format_input_for_mush(desc)
            end
            char.update(powers: powers)
            return []
        end
      
        def self.get_powers_for_web_viewing(char, viewer)
            (char.powers || {}).map { |name, desc| {
            name: name,
            desc: Website.format_markdown_for_html(desc)
            }}
        end
      
        def self.get_powers_for_web_editing(char, viewer)
            (char.powers || {}).map { |name, desc| {
            name: name,
            desc: Website.format_input_for_html(desc)
            }}
        end
    end
end