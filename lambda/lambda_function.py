import json
import os
print('Loading function')

def lambda_handler(event, context):
    print("Received event: " + json.dumps(event, indent=2))
    print("value1 = " + event['key1'])
    print(os.getenv("foo"))
    return event['key1']  # Echo back the first key value