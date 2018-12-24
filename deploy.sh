docker build -t methuzcochain/multi-client:latest -t methuzcochain/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t methuzcochain/multi-server:latest -t methuzcochain/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t methuzcochain/multi-worker:latest -t methuzcochain/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push methuzcochain/multi-client:latest
docker push methuzcochain/multi-server:latest
docker push methuzcochain/multi-worker:latest

docker push methuzcochain/multi-client:$SHA
docker push methuzcochain/multi-server:$SHA
docker push methuzcochain/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=methuzcochain/multi-server:$SHA
kubectl set image deployments/client-deployment client=methuzcochain/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=methuzcochain/multi-worker:$SHA