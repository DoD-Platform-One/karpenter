#!/bin/bash
# fetch_aws_ip_list.sh
# Fetch all AWS IP Ranges and API endpoints. To be used in egress network policies and service entries
#
# Dependencies: curl jq yq
#
# Usage: ./fetch_aws_ip_list.sh <region1> [region2 ...]
# If no arguments are passed, $AWS_REGION will be used as the default region

REGIONS_LIST=("$@")
REGIONS_LIST=("${REGIONS_LIST[@]:-$AWS_REGION}")
AWS_IP_LIST_URL="https://ip-ranges.amazonaws.com/ip-ranges.json"
IP_LIST_FILE="iplist.txt"
REGIONS_FILE="regions.txt"
OUTPUT="chart/values.yaml"

# Check if array is empty
if [[ -z ${REGIONS_LIST[@]} ]]; then
    echo "ERROR: No regions provided."
    echo "Usage: $0 <region1> [region2 ...]"
    echo "Example: $0 us-east-1 eu-west-1"
    exit 1
fi



curl -s $AWS_IP_LIST_URL | jq -r '.prefixes[]? | select((.region as $r | ($ARGS.positional | index($r))) and (.service == "EC2" or .service == "AMAZON"))| .ip_prefix' --args "${REGIONS_LIST[@]}" | sed 's/$/:443: true/' > $IP_LIST_FILE
yq -i ".bb-common.networkPolicies.egress.from.karpenter.to.cidr=(load(\"$IP_LIST_FILE\"))" $OUTPUT

# Get regions
curl -s https://ip-ranges.amazonaws.com/ip-ranges.json | jq '.prefixes[].region | select(. as $r | ($ARGS.positional | index($r)))' --args "${REGIONS_LIST[@]}" | jq -s 'unique[]' > $REGIONS_FILE
# Configure routes
yq -i "
  .bb-common.routes.inbound.aws.hosts =
    (
      load_str(\"$REGIONS_FILE\") |
      split(\"\\n\") |
      map(select(. != \"\" and . != null)) |
      map(
        sub(\"^\\\"\"; \"\") |
        sub(\"\\\"\$\"; \"\")
      ) |
      map(
        \"ec2.\" + . + \".amazonaws.com\",
        \"eks.\" + . + \".amazonaws.com\"
      ) |
      flatten
    )
" $OUTPUT

#cleanup
rm $IP_LIST_FILE $REGIONS_FILE