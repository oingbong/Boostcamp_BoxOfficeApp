# Boostcamp_BoxOfficeApp

# 요구사항 완료

1. 화면 구성 - table, collection, detail view
2. autolayout 적용
3. 영화 정렬 기준 선택 및 내비게이션 타이틀에 표시
4. table, collection view 정렬기준 공유
5. 상세 화면에서 포스터 이미지 클릭하면 전체 화면 보기 기능

# 요구사항 미완료

1. 백그라운드에서 이미지 다운로드

# 선택 요구사항 완료

1. 네트워크 동작 중에는 indicator 표시
2. 데이터 수신 실패한 경우에 alert으로 사용자에게 안내

# 추가 코드 구현

1. Cinema 모델 객체의 싱글톤 구현 및 Table, Collection View 에서 동일한 모델 객체 사용
2. Cinema 모델 객체를 이용하여 컨트롤러와 모델의 역할 구분
3. 공통 Alert은 UIAlertController 의 subclassing 미지원으로 extension 활용
4. refreshControl 적용 및 indicator와 중복 제거
5. CodingKeys 사용
