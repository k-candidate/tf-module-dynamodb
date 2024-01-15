import boto3

endpoint_url = "http://localhost.localstack.cloud:4566"
region_name = "us-east-1"

dynamodb = boto3.client("dynamodb", endpoint_url=endpoint_url, region_name=region_name)

ssm = boto3.client('ssm',endpoint_url=endpoint_url)
parameter = ssm.get_parameter(Name='/dev/table_name')['Parameter']['Value']

print(parameter)

def insert_data(event, context):
    for record in event['Records']:
        try:
            print("test")
            payload = record["body"]
            print(str(payload))
            dynamodb.put_item(TableName=parameter, Item=payload)
        except Exception as e:
            print(e)
