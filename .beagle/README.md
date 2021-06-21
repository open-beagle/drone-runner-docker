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

docker run -it \
--rm \
--entrypoint bash \
-v $PWD/:/go/src/github.com/drone-runners/drone-runner-docker \
-v /go/pkg:/go/pkg \
-w /go/src/github.com/drone-runners/drone-runner-docker \
-e GOPROXY=https://goproxy.cn \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.16.5-alpine \
.beagle/build.sh
```
