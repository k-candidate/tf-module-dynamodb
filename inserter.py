import boto3

endpoint_url = "http://localhost.localstack.cloud:4566"
region_name = "us-east-1"

dynamodb = boto3.client("dynamodb", endpoint_url=endpoint_url, region_name=region_name)

ssm = boto3.client('ssm')
parameter = ssm.get_parameter(Name='/dev/table_name')

print(parameter['Parameter']['Value'])
print(event['Records']["body"])

def insert_data(event, context):
    dynamodb.put_item(TableName=parameter['Parameter']['Value'], Item=event['Records']["body"])
