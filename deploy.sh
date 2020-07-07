docker build -t jhillieritrs/multi-client:latest -t jhillieritrs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jhillieritrs/multi-server:latest -t jhillieritrs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jhillieritrs/multi-worker:latest -t jhillieritrs/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jhillieritrs/multi-client:latest
docker push jhillieritrs/multi-server:latest
docker push jhillieritrs/multi-worker:latest
docker push jhillieritrs/multi-client:$SHA
docker push jhillieritrs/multi-server:$SHA
docker push jhillieritrs/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jhillieritrs/multi-client:$SHA
kubectl set image deployments/server-deployment server=jhillieritrs/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jhillieritrs/multi-worker:$SHA