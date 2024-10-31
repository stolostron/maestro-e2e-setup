# Setup

## Setup Maestro server

Run following command to deploy a Maestro server on a given cluster

```sh
export KUBECONFIG=""
export REGION=""
export VPC=""

make rosa/setup-maestro
```

After the Maestro server is deployed, 

## Setup Maestro agent

Run following command to deploy a Maestro agent on a given cluster

```sh
export KUBECONFIG=""
export REGION=""
export CONSUMER_ID=""

make rosa/setup-agent
```

## Run a Maestro e2e on a ROSA cluster

### Prepare

1. Install the following CLIs
	- `oc`
	- `rosa`
	- `aws`
	- `jq`
	- the [`krelay` plugin](https://github.com/knight42/krelay)

2. Create a rosa cluster, for example

```sh
rosa create cluster --cluster-name=maestro-rosa-e2e --region=us-west-2 --sts --mode=auto
```

3. Setup e2e env

```sh
export KUBECONFIG="<your_rosa_cluster_kubeconfig>"
export REGION="<your_rosa_cluster_region>"
export CLUSTER_ID="<your_rosa_cluster_name_or_id>"

make rosa/setup-e2e
```

### Run Maestro e2e

1. Clone the [Maestro code](https://github.com/openshift-online/maestro) to a directory

2. Run the Maestro e2e

```sh
ginkgo -v --fail-fast --label-filter="!(e2e-tests-spec-resync-reconnect||e2e-tests-status-resync-reconnect)" \
	--output-dir="$(pwd)/_output/e2e_rosa/report" --json-report=report.json --junit-report=report.xml \
	"<your-maestro-code-dir>/test/e2e/pkg" -- \
	-api-server="http://127.0.0.1:8000" \
	-grpc-server="127.0.0.1:8090" \
	-server-kubeconfig=<your_rosa_cluster_kubeconfig> \
	-agent-kubeconfig=<your_rosa_cluster_kubeconfig> \
	-consumer-name=$(pwd)/_output/consumer_id
```

### Cleanup

1. Run following commands to cleanup the AWS IoT and RDS resources

```sh
export KUBECONFIG="<your_rosa_cluster_kubeconfig>"
export REGION="<your_rosa_cluster_region>"
make rosa/teardown
```

2. Delete the ROSA cluster, for example

```sh
rosa delete cluster --cluster=maestro-rosa-e2e 
```
