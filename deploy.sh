docker build -t orjanbv/multi-client:latest -t orjanbv/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t orjanbv/multi-server:latest -t orjanbv/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t orjanbv/multi-worker:latest -t orjanbv/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push orjanbv/multi-client:latest
docker push orjanbv/multi-server:latest
docker push orjanbv/multi-worker:latest

docker push orjanbv/multi-client:$GIT_SHA
docker push orjanbv/multi-server:$GIT_SHA
docker push orjanbv/multi-worker:$GIT_SHA

kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=orjanbv/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=orjanbv/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=orjanbv/multi-worker:$GIT_SHA
