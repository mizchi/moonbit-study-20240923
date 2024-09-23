# Moonbit を紹介する

## 今日のコンテキスト

過去に書いた記事

https://zenn.dev/mizchi/articles/introduce-moonbit

[『RustによるWebアプリケーション開発 設計からリリース・運用まで』という本を共著で書きました](https://blog-dry.com/entry/2024/09/15/142950)

> Rustってバックエンド開発に向いてるの？
> (中略) あまり深く考えずに字面通り答えるなら、本書を書いた以上は「向いている」と言いたいところですが、私個人としては「Rustでも実装できるし運用できる」くらいの感覚を持っています。上述した通り、現代におけるJavaやPHP、Ruby on Railsなどの立ち位置になるのはちょっと難しいのではないか？と思っています。そもそもシステムプログラミング言語ですしね。

俺「Moonbitはいいぞ」

課題感がありそうな __syumai さんを捕まえて、ペアプロしつつ紹介したい。

(でもたまにキャッチアップしてる程度だから、うろおぼえで、最新機能を知らないかも)

## Moonbit 言語とは

https://www.moonbitlang.com/

- WebAssembly を主なターゲットにした GC 付き Rust 風の言語
  - WebAssembly First + GC なので豊富な表現力に対して、生成サイズが非常に小さい
- 開発母体は深圳の研究組織 IDEA (たぶん大学院大学みたいなポジション？)
  - 元 Meta で ReScript (OCamlのJS風糖衣構文からJSを生成) を開発していた Hongbo Zhang が主に設計
- コンパイラ本体はまだ未公開だが、たぶんコンパイラ周辺が OCaml で周辺ツールチェインが Rust

肌感として、アプリケーションコードを書ける Rust 風味の関数型言語

## あるもの

- LSP
  - ✅ Auto Completion
  - ✅ Rename
  - ✅ Warning
  - ✅ In Lay Hints
- ToolChain
  - ✅ CLI
  - ✅ VSCode Extensions
  - ✅ formatter: `moon fmt`
  - ⚠ package manager https://mooncakes.io/
- Compile Target
  - ✅ WebAssembly
  - ✅ JS
  - 🔲 Native
    - Hongbo氏がネイティブコンパイルの結果を X にスクリーンショットを貼っていた
- Language Features
  - ✅ Error Handling
  - ✅ Trait
  - ✅ Generics
  - 🔲 async await


## Moonbit への自分の認識

- これだけ高い表現力で、最適化された WASMバイナリが出てくる言語は、既に唯一無二
  - バイナリが小さいがシステムレベル: rust, zig, C++
  - 高級だが出力が大きい: Go, C#, MRuby, etc...
- 非同期表現/ランタイムが(まだ)ないので、現時点で JS を置き換えるのは難しい
- パッケージレジストリは数が少ない+破壊的な変更で動かなくなってるのが多い

## 最低限のセットアップ

公式のセットアップガイド

https://www.moonbitlang.com/download/

CLI のインストール

```bash
curl -fsSL https://cli.moonbitlang.com/install/unix.sh | bash
# パスを通す
```

VSCode 拡張

https://marketplace.visualstudio.com/items?itemName=moonbit.moonbit-lang


## 迷った時の主な参照リソース

- 最新情報
  - 公式 X https://twitter.com/moonbitlang 
  - メイン開発者 https://twitter.com/bobzhang1988
  - 公式ブログ https://www.moonbitlang.com/weekly-updates
    - プロトタイプレベルで出てくるので次のアプデで仕様が変わりがち
- 動いているコード: https://github.com/moonbitlang/core
  - Map, Array, inspect 等の標準ライブラリがセルフホストされている
  - 文法に困ったらこのリポジトリで検索すると、最新仕様で書かれたコードが出てくる
  - コアメンバーの peter-jerry-ye 氏の作るライブラリ https://github.com/peter-jerry-ye
    - 発展的な機能はこの人。例えばメモリアロケータ https://github.com/peter-jerry-ye/memory

## 以下はペアプロ

https://www.fermyon.com/
https://www.moonbitlang.com/blog/ai-agent

## モジュールシステム

ハマりそうなモジュール周りだけ解説

```
$ moon new my-mbt-app
```

次のようなディレクトリ構成が生成される。

```
moon.mod.json
src/
  lib/
    moon.pkg.json
  main/
    moon.pkg.json
```

### moon.mod.json

package.json 相当

name は最初は `username/hello` になっている。

```json
{
  "name": "mizchi/example",
  "version": "0.1.0",
  "readme": "README.md",
  "repository": "",
  "license": "Apache-2.0",
  "keywords": [],
  "description": "",
  "source": "src"
}
```

### src/main/moon.pkg.json

moon.pkg.json が置かれた場所が create に相当

```json
{
  "is-main": true,
  "import": ["mizchi/example/lib"]
}
```

### src/lib/lib.mbt

```json
{}
```

name は省略すると `{moon.mod.json#name}/{srcからの相対パス}` になってそう。
