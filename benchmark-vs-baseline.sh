#!/bin/bash

base=''
branch=master

[ -n "$1" ] && branch=$1
shift

basedir=$(dirname $0)

#echo $basedir/benchmark-branch.sh "$branch"

run_data=$($basedir/benchmark-branch.sh "$branch")
new_run=$(echo $run_data | cut -d'|' -f3)

while [ $# -gt 0 ]
do
	base_run=$1
	base_branch=$2
	shift
	shift

	php xhprof-check.php "$base_run" "$new_run" "$base_branch..$branch"
done

#echo "---"
#echo "fc = function calls, wt = wall time, cpu = cpu time used, mu = memory usage, pmu = peak memory usage"