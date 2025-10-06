import * as awsClassic from "@pulumi/aws";
import * as awsNative from "@pulumi/aws-native";
import * as pulumi from "@pulumi/pulumi";

const stackName = pulumi.getStack();

if (stackName.endsWith("native")) {
	new awsNative.s3.Bucket(`pulumi-${stackName}`);
} else {
	new awsClassic.s3.Bucket(`pulumi-${stackName}`);
}
