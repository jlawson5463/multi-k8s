docker build -t jlaws/multi-client -f ./client/Dockerfile ./client
docker build -t jlaws/multi-server -f ./server/Dockerfile ./server
docker build -t jlaws/multi-worker -f ./worker/Dockerfile ./worker

kubectl rollout restart deployment/server-deployment
kubectl rollout restart deployment/client-deployment
kubectl rollout restart deployment/worker-deployment

docker push jlaws/multi-client
docker push jlaws/multi-server
docker push jlaws/multi-worker

kubectl apply -f k8s