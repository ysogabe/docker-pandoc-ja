---
title: 日本語文書
author: 曽我部 芳生
date: 2024年3月5日
documentclass: ltjsarticle
---
# Pandoc Japanese PDF Docker Image

このリポジトリには、日本語PDFファイルを生成できるPandocのDockerイメージを構築するためのDockerfileが含まれています。

## 特徴

- pandoc/core:latest-ubuntuをベースイメージとして使用
- 日本語フォント（IPAex）のサポート
- LuaLaTeXによる日本語文書処理
- デフォルトの日本語テンプレート

## 使用方法

### イメージのビルド

```bash
docker build -t pandoc-latex-ja .
```

### PDF出力設定

Markdownファイルの先頭に、YAMLヘッダーを記述することでPDF出力の設定を行うことができます。
**重要**: 日本語PDFを生成する場合、`documentclass: ltjsarticle` の指定は必須です。

```yaml
---
title: 文書タイトル   # 文書のタイトル
author: 作成者名     # 著者名
date: 2024年3月5日   # 作成日付
documentclass: ltjsarticle  # 日本語LaTeXドキュメントクラス（必須）
classoption:        # ドキュメントクラスのオプション
  - titlepage      # タイトルページを生成
  - a4paper        # A4用紙サイズ
  - 12pt           # フォントサイズ
geometry:           # ページの余白設定
  - top=30mm       # 上余白
  - bottom=30mm    # 下余白
  - left=30mm      # 左余白
  - right=30mm     # 右余白
header-includes:    # LaTeXパッケージの追加設定
  - \usepackage{luatexja}           # 日本語処理用パッケージ
  - \usepackage[ipaex]{luatexja-preset}  # IPAexフォント設定
  - \usepackage{hyperref}           # リンクの有効化
  - \usepackage{graphicx}           # 画像の挿入
toc: true          # 目次の生成
toc-depth: 3       # 目次の深さ（見出しレベル）
numbersections: true # 見出しの番号付け
lang: ja           # 文書の言語
papersize: a4      # 用紙サイズ
mainfont: IPAexMincho # メインフォント
sansfont: IPAexGothic # サンセリフフォント
monofont: IPAexGothic # 等幅フォント
indent: true       # 段落の字下げ
linestretch: 1.5   # 行間
---
```

各設定項目の説明：
- `documentclass: ltjsarticle`: LuaTeXによる日本語文書用のドキュメントクラスを指定（必須）
- `classoption`: ドキュメントクラスのオプション設定
  - `titlepage`: 独立したタイトルページを生成
  - `a4paper`: A4用紙サイズを指定
  - `12pt`: 基本フォントサイズを指定
- `geometry`: ページのマージン設定
- `header-includes`: 追加のLaTeXパッケージと設定
  - `luatexja`: 日本語文書処理用のパッケージ
  - `luatexja-preset`: IPAexフォントを使用するための設定
  - `hyperref`: PDFのリンクを有効化
  - `graphicx`: 画像挿入用パッケージ
- `toc`: 目次の生成（true/false）
- `toc-depth`: 目次に含める見出しの深さ（1-3推奨）
- `numbersections`: 見出しの自動番号付け
- `lang`: 文書の主言語
- `papersize`: 用紙サイズ指定
- `mainfont`, `sansfont`, `monofont`: フォントファミリーの指定
- `indent`: 段落の自動字下げ
- `linestretch`: 行間の倍率

### 日本語PDFの生成

1. Markdownファイルを作成（例：`document.md`）:

```markdown
---
title: 日本語文書
author: 作成者
date: 2024年3月5日
documentclass: ltjsarticle
geometry:
  - top=30mm
  - bottom=30mm
  - left=30mm
  - right=30mm
header-includes:
  - \usepackage{luatexja}
  - \usepackage[ipaex]{luatexja-preset}
---

# はじめに

これは日本語PDFのテストです。
```

2. PDFファイルの生成:

```bash
docker run --rm -v $(pwd):/data pandoc-latex-ja document.md -o output.pdf --pdf-engine=lualatex
```

## 必要条件

- Docker
- インターネット接続（初回ビルド時）

## インストールされるパッケージ

- texlive-lang-japanese
- texlive-fonts-recommended
- texlive-latex-extra
- texlive-luatex
- fonts-ipaexfont
- fonts-ipaexfont-gothic
- fonts-ipaexfont-mincho

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。

## 貢献

バグ報告や機能改善の提案は、GitHub Issuesを通じてお願いします。

## 注意事項

- このイメージは元のPandocのENTRYPOINTを維持しています
- 作業ディレクトリは`/data`に設定されています
- 必要に応じてTeXLiveのパッケージを追加インストールできます