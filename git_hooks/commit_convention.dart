import 'dart:io';

dynamic main() {
  final rootDir = Directory.current;
  final commitFile = File("${rootDir.path}/.git/COMMIT_EDITMSG");
  final commitMessage = commitFile.readAsStringSync();

  final regExp = RegExp(
    '(fix|feat|wip|none|chore|refactor|docs|style|test):.+',
  );

  final valid = regExp.hasMatch(commitMessage);
  if (!valid) {
    print('''👎 잘못된 커밋 메세지입니다!

  아래 예제를 참고해주세요

  "<작업자 이름>, <Prefix>:: 커밋 내용"
  "

  사용가능한 commit의 Prefix는 아래와 같습니다.
  
  ======================= 반드시 콜론을 두 개(::)를 사용하고 띄어쓰기 후 내용을 입력합니다. =======
  
    Feat::             새로운 기능을 추가
    Fix::              버그 수정
    Design::           CSS 등 사용자 UI 디자인 변경
    !BREAKING CHANGE:: 커다란 API 변경의 경우
    !HOTFIX::          급하게 치명적인 버그를 고쳐야하는 경우
    Style::            코드 포맷 변경, 세미 콜론 누락, 코드 수정이 없는 경우
    Refactor::         코드 리팩토링
    Comment::          필요한 주석 추가 및 변경
    Docs::             문서 수정
    Test::             빌드 업무 수정, 패키지 매니저 수정, 패키지 관리자 구성 등 업데이트, Production Code 변경 없음
    Rename::           파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우
    Remove::           파일을 삭제하는 작업만 수행한 경우
  
  ==================================================================================

    ''');
    exitCode = 1;
  } else {
    print('''👍 나이스한 커밋 메세지입니다!''');
  }
}
