docker build -t sort3d/multi-client:latest -t sort3d/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sort3d/multi-server:latest -t sort3d/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sort3d/multi-worker:latest -t sort3d/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sort3d/multi-client:latest
docker push sort3d/multi-server:latest
docker push sort3d/multi-worker:latest
docker push sort3d/multi-client:$SHA
docker push sort3d/multi-server:$SHA
docker push sort3d/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=sort3d/multi-client:$SHA
kubectl set image deployments/server-deployment server=sort3d/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=sort3d/multi-worker:$SHA

