# Manual Create Queue

Step 1: kubectl exec -it localstack /bin/bash

Step 2: 

```sh
awslocal sqs send-message \
  --queue-url http://localhost:4566/000000000000/${QUEUE_NAME} \
  --message-body '{"type" : "asdfadf", "event":"signup","userId":"abc123","timestamp":"2025-06-02T10:00:00Z"}'
```
