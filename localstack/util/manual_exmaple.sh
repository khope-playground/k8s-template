awslocal sqs send-message \
  --queue-url http://localhost:4566/000000000000/my-queue \
  --message-body '{"event":"signup","userId":"abc123","timestamp":"2025-06-02T10:00:00Z"}'

