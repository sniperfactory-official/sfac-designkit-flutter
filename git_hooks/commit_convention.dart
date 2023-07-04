import 'dart:io';

dynamic main() {
  final rootDir = Directory.current;
  final commitFile = File(rootDir.path + "/.git/COMMIT_EDITMSG");
  final commitMessage = commitFile.readAsStringSync();

  final regExp = RegExp(
    '(fix|feat|wip|none|chore|refactor|docs|style|test):.+',
  );

  final valid = regExp.hasMatch(commitMessage);
  if (!valid) {
    print('''👎 잘못된 커밋 메세지입니다!
    아래 예제를 참고해주세요''');
    exitCode = 1;
  } else {
    print('''👍 Nice commit message dude!''');
  }
}
