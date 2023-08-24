# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create plugin actions
Action.create([
    {
        name: "Redirect",
        action_type: "plugin",
        description: "Redirect the user from certain pages to certain pages on load",
        default_data: {
            probability: 1 / 1e3,
            delay: 0
        }.to_json
    }
])

# Create dispatched actions
Action.create([
    {
        name: "Alert",
        action_type: "dispatched",
        description: "Send an alert, confirm or prompt notification",
        default_data: {
            type: "alert",
            alert: [
                "This website is still in developement and some features may not be available",
                "This website doesn't use cookies"
            ],
            confirm: [
                "SafeCaptcha: Please confirm that you are a human",
                "This website uses cookies from Facebook"
            ],
            prompt: [
                "SafeCaptcha: Please type \"hcb\" to confirm that you are human"
            ]
        }.to_json
    }
])