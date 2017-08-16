#There are probably way better ways of doing this...

aws ec2 describe-snapshots --profile admin --region us-east-1  --filters Name=volume-id,Values=vol-1 --query 'Snapshots[?StartTime<=`2017-07-11`].{ID:SnapshotId}' > vol-1.json
jq ".[].ID" vol-1.json > vol-1.sh
sed -i -e 's/\"snap-/\nsleep 1 \naws ec2 delete-snapshot --profile admin --snapshot-id snap-/g' vol-1.sh
sed -i -e 's/"//g' vol-1.sh
bash -ex ./vol-1.sh

# Repeat for other volumes
