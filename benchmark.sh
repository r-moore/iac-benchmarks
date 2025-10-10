export AWS_DEFAULT_REGION=eu-west-1
export AWS_ACCESS_KEY_ID=local
export AWS_SECRET_ACCESS_KEY=local
export AWS_ENDPOINT_URL=http://localhost:4566

while test $# -gt 0
do
    case "$1" in
    	## script was run with --clean argument...
        --clean)
	        # stop localstack container
	        bun run down
			# start localstack container
			bun run up
			# await localstack service readiness
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
			# create a bucket to use for storing deployment state (shared by Pulumi, SST, Terraform etc.)
			aws s3 mb s3://deployment-state --endpoint-url=http://localhost:4566 --region eu-west-1
            ;;
    esac
    shift
done

###########################################################
# Pulumi
############

cd pulumi

export PULUMI_CONFIG_PASSPHRASE=local
export PULUMI_SKIP_CONFIRMATIONS=true
export PULUMI_SKIP_UPDATE_CHECK=true

# Pulumi + LocalStack + Local File Backend
export PULUMI_BACKEND_URL=file://.
pulumi stack init local
hyperfine --runs 1 'pulumi up --stack local --skip-preview --refresh=false'
pulumi destroy --stack local --skip-preview --yes

# cleanup deployment state
rm -rf .pulumi

# Pulumi + LocalStack + Pulumi Cloud Backend
unset PULUMI_BACKEND_URL
pulumi stack init local
hyperfine --runs 1 'pulumi up --stack local --skip-preview --refresh=false'
pulumi destroy --stack local --skip-preview --yes

# cleanup deployment state
rm -rf .pulumi
