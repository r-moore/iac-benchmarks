import * as aws from "@pulumi/aws-native";

new aws.s3.Bucket("pulumi-native-local");
