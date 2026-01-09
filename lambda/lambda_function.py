import json
import os
print('Loading function')

def lambda_handler(event, context):
    now = datetime.now().strftime("%m/%d/%Y, %H:%M:%S") 
    var_env = os.environ['foo']
    print('Il est : ' + now + " "+ var_env)
    return {
        'statusCode': 200,
        'body': json.dumps('Il est : ' + now + " "+ var_env )
    }
