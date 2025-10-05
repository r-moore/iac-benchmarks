cd "$(dirname "$0")"

export PULUMI_CONFIG_PASSPHRASE=local
export PULUMI_SKIP_CONFIRMATIONS=true
export PULUMI_SKIP_UPDATE_CHECK=true
export PULUMI_BACKEND_URL=file://.

pulumi stack init local >/dev/null 2>&1
pulumi up --stack local --skip-preview --refresh=false
