

# AWS imports: Import Braket SDK modules
from braket.circuits import Circuit, Gate, Observable
from braket.devices import LocalSimulator
from braket.aws import AwsDevice

import boto3

session = boto3.Session(profile_name='sample')
client = boto3.client('s3')
response = client.list_buckets()
print(response)