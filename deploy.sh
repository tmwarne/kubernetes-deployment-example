docker build -t tmwarne/multi-client:latest -t tmwarne/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tmwarne/multi-server:latest -t tmwarne/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tmwarne/multi-worker:latest -t tmwarne/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tmwarne/multi-client:latest
docker push tmwarne/multi-server:latest
docker push tmwarne/multi-worker:latest

docker push tmwarne/multi-client:$SHA
docker push tmwarne/multi-server:$SHA
docker push tmwarne/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tmwarne/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client
kubectl set image deployments/worker-deployment worker=tmwarne/multi-worker:$SHA