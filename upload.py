#!/usr/bin/env python3

import re
import requests
import os
import sys

headers = {
    "X-Bintray-Package": "bottles",
    "X-Bintray-Version": "latest",
    "X-Bintray-Publish": "1",
    "X-Bintray-Override": "1"
}

API = "https://api.bintray.com/content/hguandl/homebrew-custom/bottles"
TARGET_FORMULA = sys.argv[1]

regex = re.compile(f"({TARGET_FORMULA}-)-(.*bottle.*\\.tar\\.gz)")
for file in os.listdir('.'):
    m = re.fullmatch(regex, file)
    if m:
        upload_name = m.group(1) + m.group(2)
        print(f"Upload {upload_name}...")
        with open(file, "rb") as f:
            r = requests.put(f"{API}/{upload_name}", headers=headers, data=f.read())
            print(r.text)
