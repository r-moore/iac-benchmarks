cd "$(dirname "$0")"

export PULUMI_CONFIG_PASSPHRASE=local
export PULUMI_SKIP_CONFIRMATIONS=true
export PULUMI_SKIP_UPDATE_CHECK=true
export PULUMI_BACKEND_URL=file://.

pulumi destroy --stack local --skip-preview --yes
rm -rf .pulumi
