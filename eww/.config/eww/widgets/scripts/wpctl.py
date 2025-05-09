#!/usr/bin/env python3

import subprocess
from json import loads, dumps

selected = subprocess.run("pactl get-default-sink", shell=True, text=True, stdout=subprocess.PIPE).stdout.strip()

command = 'pw-dump | jq \'.[] | select(.type == "PipeWire:Interface:Node" and .info.props."media.class" == "Audio/Sink")\' | jq -s'

result = subprocess.run(command, shell=True, text=True, stdout=subprocess.PIPE).stdout

result_json = loads(result)
volume_symbol = " "
sinks = [
    {
        "id": sink["id"],
        "name": (volume_symbol if sink["info"]["props"]["node.name"] == selected else " ")
        + "   "
        + (
            sink["info"]["props"]["node.nick"]
            if "node.nick" in sink["info"]["props"].keys()
            else sink["info"]["props"]["node.description"]
        ),
    }
    for sink in result_json
]

for i, s in enumerate(sinks[:]):
    if volume_symbol in s["name"]:
        playing = sinks.pop(i)
        sinks.insert(0, playing)
        break




# for sink in result_json:
#     print(f"id {sink["id"]}")
#     print(f"name {sink["info"]["props"].get("media.name", sink["info"]["props"]["node.description"])}")


print(dumps(sinks))
