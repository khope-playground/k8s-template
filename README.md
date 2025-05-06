# k8s-template

플레이그라운드에서 쓸 서버들 배포 템플릿 리드미 gpt시킴킴

## 디렉터리 구조

```
k8s/
├── base/                   # namespace 등 공통 리소스
│   └── namespace.yaml
├── spring/                 # Deployment, Service, Probe 설정
│   ├── deployment.yaml
│   └── service.yaml
├── mysql/                  # StatefulSet, Secret, PVC
│   ├── secret.yaml
│   ├── pvc.yaml
│   ├── statefulset.yaml
│   └── service.yaml
├── redis/                  # ConfigMap, StatefulSet, Headless Service, Init Job, Probe
│   ├── service-headless.yaml
│   ├── configmap.yaml
│   ├── statefulset.yaml
│   └── init-cluster-job.yaml
└── monitoring/             # Prometheus & Grafana 모듈
    ├── prometheus-configmap.yaml
    ├── prometheus-deploy.yaml
    └── grafana-deploy.yaml
```

## spring/

* 여러 replica로 Spring Boot 앱 배포.
* `/actuator/health` 기반 LivenessProbe, ReadinessProbe 설정.
* ClusterIP Service로 내부 통신 제공.

## mysql/

* StatefulSet 기반 단일 MySQL 인스턴스 배포.
* PVC로 데이터 영속성 보장.
* 비밀번호는 Secret으로 관리.

## redis/

* 6개 노드(3 Master + 3 Replica) Redis Cluster 배포.
* ConfigMap으로 `redis.conf` 설정 주입.
* Headless Service로 Pod 간 DNS 통신 지원.
* TCP 6379 기반 Probe 설정.
* Init Job으로 클러스터 자동 초기화 (`redis-cli --cluster create ... --cluster-yes`).

## monitoring/

* Prometheus로 메트릭 수집 환경 제공.
* Grafana로 대시보드 시각화 환경 제공.
* ConfigMap에 Spring 앱 타겟 등록.

## 배포 방법

```bash
kubectl apply -f k8s/base/namespace.yaml  
kubectl apply -f k8s/mysql/  
kubectl apply -f k8s/redis/  
kubectl apply -f k8s/spring/  
kubectl apply -f k8s/monitoring/  
```

Kustomize 사용 시:

```bash
kubectl apply -k k8s/
```
