#!/usr/bin/env python3

from requests.structures import CaseInsensitiveDict
import requests

def main():
    try:
        url = "https://api.pushover.net/1/messages.json"
        token = "a3c3z5o1mzjhv5utf7qw14pf883van"
        user = "unkrwkzjge72dfidyph4qkxzgbx9jo"
        device = "Guchkooh"
        payload = "token=%s&user=%s&device=%s&title=%s&message=%s" % (token, user, device, "It's clown time!", "Clown time, clown time!")

        headers = CaseInsensitiveDict()
        headers["content-Type"] = "application/x-www-form-urlencoded"

        requests.post(url, data=payload, headers=headers)
    except:
        print("Failed to send \"It's clown time!\" to Guchkooh")

if __name__ == "__main__":
    main()
