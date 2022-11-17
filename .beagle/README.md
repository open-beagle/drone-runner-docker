# version

```bash
git remote add upstream git@github.com:drone-runners/drone-runner-docker.git

git fetch upstream

git merge v1.8.0
```

## debug

```bash
git apply .beagle/0001-lables.patch
git apply .beagle/0002-disable-create-network.patch
git apply .beagle/0003-ci-workspace.patch

docker run -it --rm \
-v $PWD/:/go/src/github.com/drone-runners/drone-runner-docker \
-w /go/src/github.com/drone-runners/drone-runner-docker \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.19 \
rm -rf vendor && go mod vendor

docker run -it --rm \
-v $PWD/:/go/src/github.com/drone-runners/drone-runner-docker \
-w /go/src/github.com/drone-runners/drone-runner-docker \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.19 \
.beagle/build.sh

docker run -it \
--rm \
-v $PWD/:/go/src/github.com/drone-runners/drone-runner-docker \
-w /go/src/github.com/drone-runners/drone-runner-docker \
registry.cn-qingdao.aliyuncs.com/wod-k8s/tmate:v2.4.0-amd64 \
cp /build/tmate release/linux/amd64/tmate
```

## cache

```bash
# 构建缓存-->推送缓存至服务器
docker run --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="cloud" \
  -e DRONE_REPO_NAME="drone-runner-docker" \
  -e DRONE_COMMIT_BRANCH="dev" \
  -e PLUGIN_MOUNT="./vendor" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="cloud" \
  -e DRONE_REPO_NAME="drone-runner-docker" \
  -e DRONE_COMMIT_BRANCH="dev" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```