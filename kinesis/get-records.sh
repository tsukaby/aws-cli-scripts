#!/bin/bash

stream_name=$1
shard_array_index=${2:-0}
shard_iterator_type=${3:-LATEST}


shard_id=$(aws kinesis describe-stream --stream-name ${stream_name} --query "StreamDescription.Shards[${shard_array_index}].ShardId" --output text)
shard_iterator=$(aws kinesis get-shard-iterator --stream-name ${stream_name} --shard-id ${shard_id} --shard-iterator-type ${shard_iterator_type} --query "ShardIterator" --output text)
aws kinesis get-records --shard-iterator ${shard_iterator}
