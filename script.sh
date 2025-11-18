#!/bin/bash
INTERVAL=30
echo "Get current number of pods in roboshop namespace:"
NUMBER_OF_PODS=$(kubectl get pods -n roboshop --no-headers | wc -l)
echo "Number of pods before restart: $NUMBER_OF_PODS"

echo "Performing rolling restart of deployments..."
kubectl rollout restart deployment -n roboshop

echo "Waiting for deployments to finish the rollout..."
kubectl rollout status deployment -n roboshop

echo "Waiting for pod count to stabilize..."

while true; do
  CURRENT_PODS=$(kubectl get pods -n roboshop --no-headers | wc -l)
  echo "Current pod count: $CURRENT_PODS"
  if [ "$CURRENT_PODS" -eq "$NUMBER_OF_PODS" ]; then
    echo "Pod count matches original. All pods likely restarted."
    break
  fi
  echo "Pods count doesn't match yet. Sleeping $INTERVAL seconds..."
  sleep $INTERVAL
done

echo "Final list of pods in roboshop:"
kubectl get pods -n roboshop

echo "Job completed successfully."
exit 0


