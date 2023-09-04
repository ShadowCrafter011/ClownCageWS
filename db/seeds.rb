# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create plugin actions
plugin_hashes = [
    {
        name: "Redirect",
        action_type: "plugin",
        description: "Redirect the user from certain pages to certain pages on load",
        documentation: """
        *Probability*: Probability that action procs
        *Delay*: If proced the extension will wait n number of milliseconds before redirecting
        """,
        default_data: {
            on: "load",
            probability: 0.1,
            delay: 0,
            urls: [
                { "*": "https://cornhub.website" },
                { "*": "https://eelslap.com" },
                { "salbot.ch": "https://puginarug.com" },
                { "pinterest": "https://google.com" }
            ]
        }
    },
    {
        name: "Cancel events",
        action_type: "plugin",
        description: "Cancels events randomly",
        documentation: """
        Name of the event: Probability that action procs
        """,
        default_data: {
            "click": 0.5,
            "keydown": 0.5
        }
    },
    {
        name: "Randomize keypress",
        action_type: "plugin",
        description: "Randomizes a keypress with a certain probability",
        documentation: """
        *Probability*: Probability that the action procs
        Key: Replacement
        """,
        default_data: {
            probability: 1,
            keydata: {
                m: "n",
                n: "m"
            }
        }
    }
]

# Create dispatched actions
dispatched_hashes = [
    {
        name: "Alert",
        action_type: "dispatched",
        description: "Send an alert, confirm or prompt notification",
        documentation: """
        *Active*: Set if the action only triggers on an active and focused tab
        *Alert, confirm, prompt*: Set default messages that get chosen at random for each popup type. Overridden if message and type are user specified
        *Prompt*: You can add a required message and an action if required message is not typed
        """,
        default_data: {
            visible: true,
            focused: true,
            bootstrap: true,
            alert: [
                "This website is still in developement and some features may not be available",
                "This website doesn't use cookies"
            ],
            confirm: [
                "SafeCaptcha: Please confirm that you are a human",
                "This website uses cookies from Facebook"
            ],
            prompt: [
                {
                    message: "SafeCaptcha: Please type \"hcb\" to confirm that you are human",
                    value: "hcb",
                    otherwise: {
                        action: "redirect",
                        to: "https://puginarug.com/",
                        probability: 0.9
                    }
                },
                {
                    message: "Type \"I'm dumb\" to confirm that you are a human because bots would never admit to be dump",
                    value: "I'm dumb",
                    otherwise: {
                        action: "replace_body",
                        with: "<h1 class=\"text-center mt-5\">Captcha failed please don't be a robot</h1>",
                        probability: 1
                    }
                }
            ]
        }
    }
]

combined_hahes = plugin_hashes + dispatched_hashes
combined_hahes.each_with_index do |action_hash, index|
    action_hash[:id] = index + 1
    action_hash[:default_data] = action_hash[:default_data].to_json
    action_doc_lines = action_hash[:documentation].strip.split("\n").map { |line| line.strip }
    bolded_lines = []
    action_doc_lines.each do |line|
        opened = false
        while line.include? "*"
            line = line.sub("*", opened ? "</strong>" : "<strong>")
            opened = !opened
        end
        bolded_lines.append line
    end
    action_hash[:documentation] = bolded_lines.join("\n")
end

Action.create(combined_hahes)