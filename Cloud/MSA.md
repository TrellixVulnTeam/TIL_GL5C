## Monolith

- 모놀로틱 아키텍처란 단일 애플리케이션을 기반으로 한 서버 측 시스템
- 개발, 배포, 관리가 쉽지만
- 한 아키텍처에서 여러 라이브러리가 공유되고 있기 때문에, 변경사항이 있을 때 문제가 있을 가능성이 크다.
- 또 언어와, 프레임워크에 종속적이다.
- 또 기능이 추가되고 확장되면, 복잡한 사항들을 알아내기 어려워진다.
- 규모가 커진 모놀로틱 아키텍처는 배포하는데 어려움이 있다.

## Micro Services

- 모든 애플리케이션 기능을 가져다가 컨테이너에서 실행되는 자체 서비스에 배치하는 '애플리케이션 아키텍처'
- 이 컨테이너들은 API를 통해 통신한다.
- 컴포넌트 들이 독립적으로 실행되고, 서로 API를 통해 통신한다.
- 서비스에 실패한 인스턴스가 있더라도, 나머지는 제대로 동작하기 때문에 위험이 줄어든다.
- 컴포넌트를 독립적으로 확장 가능하다.
- 언어와 프레임워크에 종속되지 않고, DevOps 파이프라인을 통해 원하는대로 반복할 수 있다.
