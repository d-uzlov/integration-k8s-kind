
# Performance testing

This folder contains deployment `yaml` files and scripts
that deploy, run and clear applications for performance testing.

# Parameters

Parameters to be considered are:

1. `qps_list`: requested load of the system
2. `duration`: duration of a single test
3. `connections`: the amount of simultaneous connections from test client to test server
4. `iterations`: how many times to run each test

To inspect results you can install Fortio and run `fortio server`.
In the Web-UI you will be able to see graphs for different runs and compare them.

Alternatively you can simply open `.json` files and inspect them for QPS and different latency percentiles.

# Running the tests manually locally

Checkout deployment-k8s repo in the parent folder.

Generate scripts:
```bash
# if you don't gave gotestmd installed yet
./performance_testing/scripts/generate-install.sh
./performance_testing/scripts/generate-scripts.sh ../deployments-k8s
```

If you are using kind or a bare-metal cluster,
make sure that you either have a load balancer service support in your cluster,
or set `CLUSTER1_CIDR` and `CLUSTER2_CIDR` environment variables to appropriate values,
and this script will setup MetalLB automatically.

Setup NSM prerequisites:
```bash
./performance_testing/scripts/nsm_prerequisites_setup.sh
```

Test interdomain vl3:
```bash
NSM_VERSION=v1.9.0
./performance_testing/scripts/run_test_suite.sh \
    vl3 \
    ./performance_testing/results/raw/ \
    1 \
    "http://nginx.my-vl3-network:80" \
    "./performance_testing/use-cases/vl3/deploy.sh" \
    "./performance_testing/use-cases/vl3/clear.sh" \
    "$NSM_VERSION" \
    1000000 \
    10s \
    1 \
    "./performance_testing/scripts/nsm_deploy_setup.sh" \
    "./performance_testing/scripts/nsm_deploy_cleanup.sh"
```

Test interdomain with WireGuard connection:
```bash
NSM_VERSION=v1.9.0
./performance_testing/scripts/run_test_suite.sh \
    k2wireguard2k \
    ./performance_testing/results/raw/ \
    3 \
    "http://172.16.1.2:80" \
    "./performance_testing/use-cases/k2wireguard2k/deploy.sh" \
    "./performance_testing/use-cases/k2wireguard2k/clear.sh" \
    "$NSM_VERSION" \
    1000000 \
    10s \
    1 \
    "./performance_testing/scripts/nsm_deploy_setup.sh" \
    "./performance_testing/scripts/nsm_deploy_cleanup.sh"
```

Clear cluster if needed:
```bash
./performance_testing/scripts/nsm_prerequisites_cleanup.sh
```
