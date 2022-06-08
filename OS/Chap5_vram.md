##  가상 메모리

### 여기서 잠깐! 

> 가상 메모리도 굉장히 큰 부분 
>
> 프로세스 관련 기술을 이해하면, 가상 메모리도 보다 쉽게 이해 가능 
>
> 프로세스 이해가 조금 부족하더라도, 가상 메모리에 프로세스 관련 설명이 반복되므로, 조금씩 더 이해 가능 

### 가상 메모리 (Virtual Memory System) 

> 실제 각 프로세스마다 충분한 메모리를 할당하기에는 메모리 크기가 한계가 있음 

- 예: 리눅스는 하나의 프로세스가 4GB 임 
- 통상 메모리는 8GB? 16GB? 

> 폰노이만 구조 기반이므로, 코드는 메모리에 반드시 있어야 함 

## 가상 메모리가 필요한 이유 

- 하나의 프로세스만 실행 가능한 시스템(배치 처리 시스템등) 에서는 거의 쓸 이유가 없다.

1. 프로그램을 메모리로 로드(load) 
2. 프로세스 실행 
3. 프로세스 종료 (메모리 해제) 

- 여러 프로세스 동시 실행 시스템일때 필요

1. 메모리 용량 부족 이슈 
2. 프로세스 메모리 영역간에 침범 이슈 

프로세스는 4기가로 잡아놓지만, 이 중에 CPU가 지금 쓰는 공간만 메모리에 넣어주는 식으로 동작.

즉 프로세스 4기가 중에 사용하는 곳의 주소만 찾아서 RAM에 올림

## 가상 메모리 

### 메모리가 실제 메모리보다 많아 보이게 하는 기술 

- 실제 사용하는 메모리는 작다는 점에 착안해서 고안된 기술 
- 프로세스간 공간 분리로, 프로세스 이슈가 전체 시스템에 영향을 주지 않을 수 있음

![](.\img\23.png)

### 가상 메모리 기본 아이디어 

- 프로세스는 가상 주소를 사용하고, 실제 해당 주소에서 데이터를 읽고/쓸때만 물리 주소로 바꿔주면 된다. 
- virtual address (가상 주소): 프로세스가 참조하는 주소 
- physical address (물리 주소): 실제 메모리 주소

프로세스 일부분의 가상 주소가 메모리의 어디에 올라가 있는지 >> 물리 주소

가상 주소 > 물리 주소 변환을 빠르게 하기위해 하드웨어 칩을 사용한다. 이것이 MMU 

- MMU(Memory Management Unit) 
  - CPU에 코드 실행시, 가상 주소 메모리 접근이 필요할 때, 해당 주소를 물리 주소값으로 변환해주는 하드웨어 장치

![](.\img\24.png)

메인 메모리에 실제 각 프로세스의 데이터가 조각으로 씌여 있다. 



## 페이징 시스템 (paging system)

![](.\img\25.png)

![](.\img\26.png)

![](.\img\27.png)

![](.\img\28.png)

![](.\img\29.png)

![](.\img\30.png)

- valid-invalid bit
  - Page Table 에는 해당 데이터가 물리 주소에 있는지 없는지를 나타내는 정보가 하나 더 있다.

![](.\img\31.png)

## 다중 단계 페이징 시스템

![](.\img\32.png)

![](.\img\33.png)

![](.\img\34.png)

메모리는 access time 이 오래걸린다.

그래서 한번 알아낸 물리주소는 TLB에 저장하고, 같은주소 재접근시 메모리로 가는게 아니고 TLB로 가서 얻어낸다.

- 프로세스간 공유하는 공간이 있을 시, 물리 주소를 같게 하면, 메모리 절약 가능.
- 프로세스간 동일한 물리 주소를 가리킬 수 있음 (공간, 메모리 할당 시간 절약)
- 프로세스간 공유하는 공간이 있으면, 페이지 테이블이 동일한 메모리 공간을 가리키면 된다.

![](.\img\35.png)

## 요구 페이징 (Demand Paging)

- 프로세스 모든 데이터를 메모리로 적재하지 않고, 실행 중 필요한 시점에서만 메모리로 적재함
  - 선행 페이징(prepaging)의 반대 개념 : 미리 프로세스 관련 모든 데이터를 메모리에 올려놓고 실행하는 개념
  - 더 이상 필요하지 않은 페이지 프레임은 다시 저장매체에 저장 (**페이지 교체 알고리즘 필요**)

### 페이지 폴트 (page fault)

- 어떤 페이지가 실제 물리 메모리에 없을 때 일어나는 인터럽트
- 운영체제가 page fault가 일어나면, 해당 페이지를 물리 메모리에 올림

![](.\img\36.png)

- 페이지 폴트가 자주 일어나면 ?
  - 실행되기 전, 해당 페이지를 물리 메모리에 올려야 하므로 시간이 오래걸림
- 페이지 폴트가 안 일어나게 하려면?
  - 향후 실행/참조될 코드/데이터를 미리 물리 메모리에 올리면 됨
    - 앞으로 있을 일을 예측해야 하므로 어려운 부분..

## 페이징 시스템

### 페이지 교체 정책 (page replacement policy)

- 운영체제가 특정 페이지를 물리 메모리에 올리려 하는데, 물리 메모리가 다 차있다면? 
  - 기존 페이지 중 하나를 물리 메모리에서 저장 매체로 내리고(저장)
  - 새로운 페이지를 해당 물리 메모리 공간에 올린다.

> 어떤 페이지를 물리 메모리에서 저장 매체로 내릴 것인가?

## 페이지 교체 알고리즘

- FIFO Page Replacement Algorithm
- 최적 페이지 교체 알고리즘 (OPTimal Replacement Algorithm) (OPT)
  - 앞으로 가장 오랫동안 사용하지 않을 페이지를 내리자 (그걸 어떻게 알아!!!)
  - 일반 OS에서는 구현 불가

- LRU(Least Recently Used) Page Replacement Algorithm
  - 가장 오래 전에 사용된 페이지를 교체
  - OPT 교체 알고리즘이 구현 불가하므로, 과거 기록을 기반으로 시도
  - 젤 많이 씀

- LFU(Least Frequently Used) Page Replacement Algorithm
  - 가장 적게 사용된 페이지를 내리자

- NUR(Not Used Recently) Page Replacement Algorithm

  - LRU와 마찬가지로 최근에 사용하지 않은 페이지부터 교체

  - 각 페이지마다 참조 비트, 수정 비트를 둔다 (R, M)

    - (0,0) 참조 x 수정 x, (1,0) 읽기만하고 수정x
    - (0,0),(1,0),(0,1),(1,1) 순으로 페이지 교체

    - (0,0) 쪽으로 갈수록 우선으로 교체

### 메모리 지역성

- 코드에는 loop 문이 있기 때문에, 특정 지역을 많이 참조하게 된다.

![](.\img\37.png)

페이지 스왑, 폴트 하느라 바쁨

## 세그멘테이션 (Segmentation)

- 페이징 시스템과 비교해서 알아두자

- 세그멘테이션 기법 
  - 가상 메모리를 서로 **크기가 다른 논리적 단위**인 세그먼트(Segment)로 분할 
- 페이징 기법에서는 가상 메모리를 **같은 크기의 블록**으로 분할
- 예: x86 리얼모드 
  - CS(Code Segment), DS(Data Segment), SS(Stack Segment), ES(Extra Segment) 로 세그먼트를 나누어, 메모리 접근

- 세그먼트 가상주소를 물리 주소와 매칭시키는 것은 페이징 시스템과 거의 유사

![](.\img\38.png)

![](.\img\39.png)

![](.\img\40.png)

## 가상 메모리 정리

예시 프로그램 코드(txt파일을 열지못하면 종료하고, 열면 열었다고 하는 간단한 프로그램)

![](.\img\41.png)

![](.\img\42.png)

![](.\img\43.png)

페이지를 이러케 나누지만, 실제로 사용하는 코드의 사이즈는 1KB정도로 매우 작다. 페이지 테이블을 다 만들면 손해;;

페이지 디렉토리로 만들어서 필요없는 디렉토리는 페이지 테이블 안만들기

커널 영역에 대해서는 동일 물리 주소를 가리키도록 하여 물리 메모리 공간 낭비 x

![](.\img\44.png)

### 'Lazy allocation' 최대한 할당 지연

- 실행파일이 가상 메모리를 잡고 꼭 해당 데이터가 필요한 시점이 되기 전까지 물리메모리로 페이지를 올리지 않는다.

![](.\img\45.png)



 
