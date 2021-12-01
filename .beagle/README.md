# version

```bash
git remote add upstream git@github.com:drone-runners/drone-runner-docker.git

git fetch upstream

git merge v1.6.3
```

## debug

```bash
git apply .beagle/0001-lables.patch
git apply .beagle/0002-disable-create-network.patch
git apply .beagle/0003-ci-workspace.patch

docker run -it \
--rm \
--entrypoint bash \
-v $PWD/:/go/src/github.com/drone-runners/drone-runner-docker \
-v /go/pkg:/go/pkg \
-w /go/src/github.com/drone-runners/drone-runner-docker \
-e GOPROXY=https://goproxy.cn \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.17.3-bullseye \
.beagle/build.sh

docker run -it \
--rm \
-v $PWD/:/go/src/github.com/drone-runners/drone-runner-docker \
-w /go/src/github.com/drone-runners/drone-runner-docker \
registry.cn-qingdao.aliyuncs.com/wod-k8s/tmate:v2.4.0-amd64 \
cp /build/tmate release/linux/amd64/tmate
```
