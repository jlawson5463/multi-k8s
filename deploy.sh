docker build -t jlaws/multi-client:latest -t jlaws/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jlaws/multi-server:latest -t jlaws/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jlaws/multi-worker:latest -t jlaws/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jlaws/multi-client:latest 
docker push jlaws/multi-server:latest 
docker push jlaws/multi-worker:latest 

docker push jlaws/multi-client:$SHA 
docker push jlaws/multi-server:$SHA 
docker push jlaws/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jlaws/multi-client:$SHA
kubectl set image deployments/server-deployment server=jlaws/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jlaws/multi-worker:$SHA