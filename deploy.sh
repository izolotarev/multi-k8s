docker build -t izolotarev/multi-client:latest -t izolotarev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t izolotarev/multi-server:latest -t izolotarev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t izolotarev/multi-worker:latest -t izolotarev/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push izolotarev/multi-client:latest
docker push izolotarev/multi-server:latest
docker push izolotarev/multi-worker:latest

docker push izolotarev/multi-client:$SHA
docker push izolotarev/multi-server:$SHA
docker push izolotarev/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=izolotarev/multi-server:$SHA
kubectl set image deployments/client-deployment client=izolotarev/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=izolotarev/multi-worker:$SHA