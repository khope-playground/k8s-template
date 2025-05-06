# K8s-template

본 저장소는 khope-playground에 올라갈 프로젝트들이 사용할 Kubernetes 기반 배포 템플릿. Spring Boot 애플리케이션, MySQL, Redis Cluster를 Kubernetes 환경에 배포하기 위한 설정을 포함하고 있음.

## 디렉터리 구조

```
k8s/
├── spring/          # Spring 앱 배포용 Deployment, Service
├── mysql/           # MySQL StatefulSet, Secret, PVC 등
├── redis/           # Redis Cluster 구성용 ConfigMap, StatefulSet
└── base/            # namespace 등 공통 리소스 정의
```

## 구성 설명

### spring/

Spring Boot 앱을 여러 replica로 배포하며 내부 ClusterIP 서비스로 노출함. 환경변수로 MySQL 연결정보와 Redis 클러스터 노드 정보를 주입함.

### mysql/

StatefulSet 기반 단일 인스턴스 MySQL을 배포함. PVC를 통해 데이터 영속성을 유지하며, 비밀번호는 Secret을 사용하여 관리함.

### redis/

6개 노드로 구성된 Redis Cluster 배포 구조임 (3 master, 3 replica). redis.conf는 ConfigMap으로 관리되며, Headless Service를 통해 노드 간 통신을 지원함.

클러스터 초기화는 다음 명령어로 수동 수행함:

```bash
redis-cli --cluster create \
redis-cluster-0.redis-cluster-headless:6379 \
redis-cluster-1.redis-cluster-headless:6379 \
redis-cluster-2.redis-cluster-headless:6379 \
redis-cluster-3.redis-cluster-headless:6379 \
redis-cluster-4.redis-cluster-headless:6379 \
redis-cluster-5.redis-cluster-headless:6379 \
--cluster-replicas 1
```

# 배포 방법

kustomize 없이 디렉터리별 배포:

```
kubectl apply -f base/namespace.yaml
kubectl apply -f mysql/
kubectl apply -f redis/
kubectl apply -f spring/
```



kustomize 사용 시:

`kubectl apply -k k8s-template/`
