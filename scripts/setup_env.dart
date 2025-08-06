// scripts/setup_env.dart
import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('錯誤：請提供環境名稱 (例如: development 或 production)');
    exit(1);
  }

  final envArg = args.first.toLowerCase();
  String sourceFileName;

  if (envArg.contains('prod')) {
    sourceFileName = '.env.production';
    print('🔍 偵測到 "prod" 關鍵字，選擇 production 環境。');
  } else if (envArg.contains('dev')) {
    sourceFileName = '.env.development';
    print('🔍 偵測到 "dev" 關鍵字，選擇 development 環境。');
  } else {
    print('錯誤：參數 "$envArg" 中必須包含 "dev" 或 "prod" 關鍵字。');
    exit(1);
  }
  // --- 邏輯修改結束 ---

  final targetFileName = '.env';
  final sourceFile = File(sourceFileName);

  if (!sourceFile.existsSync()) {
    print('錯誤：來源檔案 $sourceFileName 不存在！');
    exit(1);
  }

  // 複製檔案
  sourceFile.copySync(targetFileName);

  print('✅ 成功將 $sourceFileName 複製到 $targetFileName');
}
