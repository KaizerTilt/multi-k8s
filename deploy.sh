docker build -t orjanbv/multi-client:latest -t orjanbv/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t orjanbv/multi-server:latest -t orjanbv/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t orjanbv/multi-worker:latest -t orjanbv/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push orjanb/multi-client:latest
docker push orjanb/multi-server:latest
docker push orjanb/multi-worker:latest

docker push orjanb/multi-client:$GIT_SHA
docker push orjanb/multi-server:$GIT_SHA
docker push orjanb/multi-worker:$GIT_SHA

kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=orjanbv/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment server=orjanbv/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment server=orjanbv/multi-worker:$GIT_SHA
