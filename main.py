#!/usr/bin/env python
from constructs import Construct
from cdktf import App, TerraformStack, TerraformAsset, AssetType
from cdktf_cdktf_provider_aws.provider import AwsProvider
from cdktf_cdktf_provider_aws.lambda_function import LambdaFunction
from cdktf_cdktf_provider_aws.lambda_event_source_mapping import LambdaEventSourceMapping
from cdktf_cdktf_provider_aws.data_aws_caller_identity import DataAwsCallerIdentity
from cdktf_cdktf_provider_aws.scheduler_schedule import SchedulerSchedule, SchedulerScheduleFlexibleTimeWindow, SchedulerScheduleTarget
from cdktf_cdktf_provider_aws.sqs_queue import SqsQueue

class LambdaStack(TerraformStack):
    def __init__(self, scope: Construct, id: str):
        super().__init__(scope, id)
        AwsProvider(self, "AWS", region="us-east-1")
        account_id = DataAwsCallerIdentity(self, "acount_id").account_id
        # Packagage du code
        code = TerraformAsset(
            self, "code",
            path="./lambda",
            type= AssetType.ARCHIVE
        )

        # Create Lambda function
        lambda_function = LambdaFunction(self,
                "lambda",
                function_name="scheduled_lambda",
                runtime=,
                memory_size=,
                timeout=,
                role=f"arn:aws:iam::{account_id}:role/LabRole",
                filename= code.path,
                handler="lambda_function.lambda_handler",
                environment=
            )
        
        target = SchedulerScheduleTarget(
            arn=,
            role_arn=f"arn:aws:iam::{account_id}:role/LabRole"

        )

        scheduler = SchedulerSchedule(
            self, "scheduler",
            name="every minute",
            flexible_time_window={"mode":"OFF"},
            schedule_expression=,
            target=)
        


app = App()
LambdaStack(app, "cdktf_lambda")
app.synth()
