# iOS_BoxOffice

## 프로젝트 목적
기존까지 다양한 사람들과 프로젝트를 하면서 다양한 방법론 및 개념들을 배웠지만 이것을 내 스스로 정리하고
나만의 프로젝트에 녹여서 사용하지는 않았던 것 같다. (국소적으로 해당 프로젝트를 진행할때만 일시적으로 사용함)
>
이에 따라 개념 및 방법론을 다시 한번 복기하면서 정리하는 차원에서 기존에 만들어놓았던 프로젝트를 리팩토링을 해나갈 예정이다.


## 프로젝트 진행 순서
프로젝트를 무작정 리팩토링해나가는 것이 아닌 다음과 같은 순서로 진행할 예정이다.

1. 변수/함수/클래스/구조체 등 각 객체의 네이밍을 사용 목적에 맞게 수정을 하고, 반복적인 코드를 최소화할 수 있는 방법을 찾아 적용한다.
2. MVC 패턴으로 적용된 코드를 MVVM 패턴으로 변형시켜 MVC 와 MVVM 의 명확한 차이를 확인한다. (코드의 양, 구조 등)
3. POP 설계 이해를 위해 네트워크 레이어를 직접 설계하고 적용한다.
4. 기존에 노티, 프로토콜, 클로저를 사용하여 처리하던 비동기처리를 RxSwift를 사용하여 적용하여 비동기 처리 라이브러리의 장점을 파악해본다.

위와 같이 프로젝트를 진행하다가 적용이 필요한 개념이 떠오르면 순서 조정을 할 예정이다.
