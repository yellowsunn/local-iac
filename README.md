# local-iac
로컬 환경에 필요한 인프라를 코드로 정의해놓은 레포지토리

## Vagrant
Vagrant는 Vagrantfile을 작성해서 가상머신(기본값 Virtualbox) 위에 자동으로 OS를 설치하고 인프라를 프로비저닝할 수 있다.

참고: [로컬 인프라 환경 구축하기](https://velog.io/@yellowsunn/series/%EB%A1%9C%EC%BB%AC-%EC%9D%B8%ED%94%84%EB%9D%BC-%ED%99%98%EA%B2%BD-%EA%B5%AC%EC%B6%95%ED%95%98%EA%B8%B0)

![1662053789-dev-dot-product-landing-what-is-vagrant-diagram](https://user-images.githubusercontent.com/43487002/225525614-824269d7-189b-47df-a900-7d3b70e6c3bd.png)

### 실행 예시
* Vagrantfile 이 있는 경로에서 `vagrant up` 명령어 실행
```bash
$ cd vagrant/k8s_1_26
$ vagrant up
```

* 가상머신 종료 및 이미지 제거
```bash
$ vagrant destroy -f
```

## 정의한 인프라
![image](https://user-images.githubusercontent.com/43487002/225531403-03bc9a4c-5059-484a-835b-4eea68bc6690.png)
