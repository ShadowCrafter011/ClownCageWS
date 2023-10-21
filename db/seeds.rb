# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create folders
folders = [
    { name: "Tabs", action_type: "dispatched" }
]

folders.each_with_index do |folder_hash, index|
    folder_hash[:id] = index + 1
end

Folder.create folders

# Create plugin actions
plugin_hashes = [
    {
        name: "Redirect",
        description: "Redirect the user from certain pages to certain pages on load",
        documentation: """
        *Probability*: Probability that action procs
        *Delay*: If proced the extension will wait n number of milliseconds before redirecting
        """,
        default_data: {
            on: "load",
            probability: 0.1,
            delay: 0,
            urls: {
                "*": [
                    "https://cornhub.website",
                    "https://eelslap.com"
                ],
                "salbot.ch": [
                    "https://puginarug.com"
                ],
                "pinterest": [
                    "https://google.com"
                ]
            }
        }
    },
    {
        name: "Cancel events",
        description: "Cancels events randomly",
        documentation: """
        Name of the event: Probability that action procs
        <a href='https://developer.mozilla.org/en-US/docs/Web/Events#event_listing' target='_blank'>mdn event list</a>
        """,
        default_data: {
            "click": 0.5,
            "keydown": 0.5
        }
    },
    {
        name: "Randomize keypress",
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
    },
    {
        name: "Image exchange",
        description: "Change src of random images",
        documentation: """
        *Probability*: Probability that the action procs
        *Allow visible*: Forces images to be off screen for them to be swapped
        *Interval*: Repeat every n milliseconds. Execute only once if interval is -1
        *Amount*: Number of images changed per interval
        """,
        default_data: {
            probability: 0.5,
            allow_visible: false,
            interval: 5000,
            amount: 1,
            images: {
                "*":[
                    "https://media.npr.org/assets/img/2017/09/12/macaca_nigra_self-portrait-3e0070aa19a7fe36e802253048411a38f14a79f8-s1100-c50.jpg",
                    "https://www.anwalt.de/img_cache/d3/d32ab1b554a58526c4b1b8e6e5fa376a.png",
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpfID3M8t7zsCyVHlA35kZRYMdIsb5Ypy8tg&usqp=CAU",
                    "https://cdn.discordapp.com/attachments/880128435148685314/1161030380405657742/dog-bum-wearing-thong-underwear-white-background-dog-bum-wearing-thong-106357113.png?ex=6536d0cd&is=65245bcd&hm=d3db7b7fec7d1023a7c76de1d29cc406d9449afc50aa47ed2c7ad64c57e9e45e&"
                ],
                "lonelyplanet.com": [
                    "https://cdnb.artstation.com/p/assets/images/images/041/465/061/large/yh-cheng-il1708-2-chengyiharng-1605087-v3.jpg?1631775579",
                    "https://cdnb.artstation.com/p/assets/images/images/026/435/053/large/z-k-il1708-2-wongzikuan-1705042-epicnaturefinal-refine.jpg?1588776168"
                ]
            }
        }
    },
    {
        name: "Action on",
        description: "Bind action to specific events",
        documentation: """
        """,
        default_data: {
            bootstrap: true,
            :"keypress.enter" => {
                probability: 0.5,
                action: "redirect",
                to: "https://monkeytype.com"
            },
            click: {
                probability: 0.5,
                action: "replace_body",
                with: "<h1 class='text-center mt-5'>You clicked too fast, slow down!</h1>"
            },
            submit: {
                probability: 0.5,
                prevent_default: true,
                action: "play_sound",
                source: "https://salbot.ch/audio/rick.mp3"
            }
        }
    },
    {
        name: "Captcha",
        description: "Randomly captcha a website",
        documentation: """
        """,
        default_data: {
            bootstrap: true,
            visible: true,
            focused: true,
            captcha_data: {
                "*": [
                    "monkeytype",
                    "tiktaktoe"
                ],
                "pinterest": [
                    "geoguessr"
                ],
                "bs.to": [
                    "chess"
                ]
            }
        }
    }
]

# Create dispatched actions
dispatched_hashes = [
    {
        name: "Alert",
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
    },
    {
        name: "Change Links",
        description: "Change one or more links on a website",
        documentation: """
        """,
        default_data: {
            visible: true,
            focused: true,
            bootstrap: false,
            links: {
                "*": [
                    "https://cornhub.website",
                    "https://eelslap.com"
                ],
                "pinterest": [
                    "https://portal.sbl.ch"
                ]
            }
        }
    },
    {
        name: "Redirect",
        description: "Redirect user to specific webpage",
        documentation: """
        Old URL must contain: New URL
        """,
        default_data: {
            visible: true,
            focused: true,
            bootstrap: false,
            links: {
                "*": [
                    "https://amionline.net/",
                    "https://www.google.com/robots.txt"
                ],
                "portal.sbl.ch": [
                    "https://longdogechallenge.com/"
                ]
            }
        }
    },
    {
        name: "Open Tab",
        context: "background",
        folder: "Tabs",
        description: "Open a tab with a specified link",
        documentation: """
        """,
        default_data: {
            amount: 1,
            links: [
                "https://google.com"
            ]
        }
    },
    {
        name: "Close Tab",
        context: "background",
        folder: "Tabs",
        description: "Close one or more tabs",
        documentation: """
        """,
        default_data: {
            random: true,
            amount: 1
        }
    },
    {
        name: "Shuffle Tabs",
        context: "background",
        folder: "Tabs",
        description: "Shuffle tabs into a random order",
        documentation: "",
        editable: false,
        default_data: {
            nothing: "here"
        }
    },
    {
        name: "Print",
        description: "Show the print menu on the current page",
        documentation: "",
        default_data: {
            visible: true,
            focused: true
        }
    },
    {
        name: "Play Sound",
        description: "Play a sound on the current webpage",
        documentation: "",
        default_data: {
            visible: true,
            focused: true,
            sources: [
                "https://salbot.ch/audio/rick.mp3"
            ]
        }
    }
]

plugin_hashes.each_with_index do |plugin_hash, index|
    plugin_hash[:action_type] = "plugin"
    plugin_hash[:id] = index + 1000
end

dispatched_hashes.each_with_index do |dispatch_hash, index|
    dispatch_hash[:action_type] = "dispatched"
    dispatch_hash[:id] = index + 2000
end

combined_hahes = plugin_hashes + dispatched_hashes
combined_hahes.each_with_index do |action_hash, index|
    if action_hash[:folder].present?
        folder_id = Folder.find_by(name: action_hash[:folder]).id
        action_hash[:folder_id] = folder_id
        action_hash.delete(:folder)
    end

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

Action.create! combined_hahes
