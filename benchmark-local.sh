export PULUMI_CONFIG_PASSPHRASE=local
export PULUMI_SKIP_CONFIRMATIONS=true
export PULUMI_SKIP_UPDATE_CHECK=true

# stop localstack
bun run down
# cleanup any old pulumi state
rm pulumi/.pulumi/stacks/pulumi/local*
rm -rf pulumi/.pulumi/locks/organization/pulumi/local
# start localstack
bun run up

echo "Waiting for localstack to start..."
for i in {1..15}; do
    if nc -z -w 1 localhost 4566; then
        echo "Localstack is ready"
        break
    fi
    if [ $i -eq 15 ]; then
        echo "Localstack not running after 15 seconds"
        exit 1
    fi
    sleep 1
done

# create a bucket to use for storing deployment state
awslocal s3 --region eu-west-1 mb s3://deployment-state

export PULUMI_BACKEND_URL=s3://deployment-state
bun run -F=pulumi init:local
hyperfine --runs 1 'bun run -F=pulumi up:local'
bun run -F=pulumi destroy:local

export PULUMI_BACKEND_URL=file://.
bun run -F=pulumi init:local
hyperfine --runs 1 'bun run -F=pulumi up:local'
bun run -F=pulumi destroy:local
