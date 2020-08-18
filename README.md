# CORE Helm chart

[Core](https://coreblockchain.cc/) is a decentralized platform for building applications using blockchain.

## TL;DR;

```console
$ helm install https://charts.coreblockchain.cc/helm-core/
```

## Introduction

This chart deploys a [Core](https://coreblockchain.cc/) network onto a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager. This chart is comprised of 4 components:

1. *bootnode*: used for Gocore node discovery
1. *stats*: [Core Network Stats](https://github.com/core-coin/stats)
1. *gocore-miner*: Gocore miner nodes
1. *gocore-tx*: Gocore transaction nodes with mining disabled whose responsibility is to respond to API (websocket, rpc) queries

## Prerequisites

* Kubernetes 1.8

## Installing the Chart

1. Create a Core address and private key.

2. Install the chart as follows:

```console
$ helm install --name my-release https://charts.coreblockchain.cc/helm-core/
    --set gocore.account.address=[PUBLIC_ADDRESS]
    --set gocore.account.privateKey=[PRIVATE_KEY]
    --set gocore.account.secret=[SECRET]
```

using the above generated example, the configurations would equate to:

* `gocore.account.address` = `0xab70383d9207c6cc43ab85eeef9db4d33a8ad4e8`
* `gocore.account.privateKey` = `38000e15ca07309cc2d0b30faaaadb293c45ea222a117e9e9c6a2a9872bb3bcf`
* `gocore.account.secret` = any passphrase that Gocore will use to encrypt your private key

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the vault chart and their default values.

| Parameter                     	| Description                                                         	| Default                                          	|
|-------------------------------	|---------------------------------------------------------------------	|--------------------------------------------------	|
| `imagePullPolicy`             	| Container pull policy                                               	| `IfNotPresent`                                   	|
| `nodeSelector`                	| Node labels for pod assignmen                                       	|                                                  	|
| `bootnode.image.repository`   	| bootnode container image to use                                     	| `docker.pkg.github.com/core-coin/go-core/gocore` 	|
| `bootnode.image.tag`          	| bootnode container image tag to deploy                              	| `v1.0.0`                                         	|
| `stats.image.repository`      	| stats container image to use                                        	| `docker.pkg.github.com/core-coin/stats/stats`    	|
| `stats.image.tag`             	| stats container image tag to deploy                                 	| `latest`                                         	|
| `stats.webSocketSecret`       	| stats secret for posting data                                       	| `my-secret-for-connecting`                       	|
| `stats.service.type`          	| k8s service type for stats                                          	| `LoadBalancer`                                   	|
| `gocore.image.repository`     	| gocore container image to use                                       	| `docker.pkg.github.com/core-coin/go-core/gocore` 	|
| `gocore.image.tag`            	| gocore container image tag to deploy                                	| `v1.0.0`                                         	|
| `gocore.tx.replicaCount`      	| gocore transaction nodes replica count                              	| `2`                                              	|
| `gocore.tx.service.type`      	| k8s service type for gocore transaction nodes                       	| `ClusterIP`                                      	|
| `gocore.tx.args.rpcapi`       	| APIs offered over the HTTP-RPC interface                            	| `xcb,net,web3`                                   	|
| `gocore.miner.replicaCount`   	| gocore miner nodes replica count                                    	| `3`                                              	|
| `gocore.miner.account.secret` 	| gocore account secret                                               	| `my-secret-account-password`                     	|
| `gocore.genesis.networkId`    	| Core network id                                                     	| `1`                                              	|
| `gocore.genesis.difficulty`   	| Core network difficulty                                             	| `0x0400`                                         	|
| `gocore.genesis.energyLimit`  	| Core network energy limit                                           	| `0x8000000`                                      	|
| `gocore.account.address`      	| Gocore Account to be initially funded and deposited with mined Core 	|                                                  	|
| `gocore.account.privateKey`   	| Gocore Private Key                                                  	|                                                  	|
| `gocore.account.secret`       	| Gocore Account Secret                                               	|                                                  	|

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example, to configure the networkid:

```console
$ helm install https://charts.coreblockchain.cc/helm-core/ --name core --set gocore.genesis.networkid=1
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install https://charts.coreblockchain.cc/helm-core/ -f values.yaml
```
