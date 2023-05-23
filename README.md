# rpathとrunpath

Linux OSにおいて共有ライブラリをロードするときのRUNPATHとRPATHの挙動を確認するサンプルプログラム

## かいせつ

ディレクトリ`mylibA`, `mylibB`に作成される`.so`ファイルが呼び出されるされる共有ライブラリです。

ディレクトリ`uselib`に作成されるいくつかの実行形式が`mylibA`,`mylibB`の`.so`ファイルをリンクして使います。
ただし、それぞれの実行形式でrpathやrunpathが設定がことなるため`mylibA`,`mylibB`のどちらにリンクされるかが変わってきます

| 実行形式                | 設定内容                           |
|:--|:--|
| `uselib_none`           | rpathもrunpathの設定もなし         |
| `uselib_rpath`          | rpathを`./mylibA`に設定            |
| `uselib_runpath_rel`    | runpathを`./mylibA`に設定          |
| `uselib_runpath_abs`    | runpathを`$PWD/../mylibA`に設定    |
| `uselib_runpath_origin` | runpathを`$ORIGIN/../mylibA`に設定 |

## 実行方法

```
git clone https://github.com/kenyog/example_rpath_runpath.git
cd example_rpath_runpath
make
make run
```

## 実行結果概要

```
$ make run
./uselib/uselib_none           ; echo
./uselib/uselib_none: error while loading shared libraries: libmylib.so: cannot open shared object file: No such file
 or directory

./uselib/uselib_rpath          ; echo
Hello, I'm library A.

./uselib/uselib_runpath_rel    ; echo
Hello, I'm library A.

./uselib/uselib_runpath_abs    ; echo
Hello, I'm library A.

./uselib/uselib_runpath_origin ; echo
Hello, I'm library A.

LD_LIBRARY_PATH=./mylibB ./uselib/uselib_none           ; echo
Hello, I'm library B.

LD_LIBRARY_PATH=./mylibB ./uselib/uselib_rpath          ; echo
Hello, I'm library A.

LD_LIBRARY_PATH=./mylibB ./uselib/uselib_runpath_rel    ; echo
Hello, I'm library B.

LD_LIBRARY_PATH=./mylibB ./uselib/uselib_runpath_abs    ; echo
Hello, I'm library B.

LD_LIBRARY_PATH=./mylibB ./uselib/uselib_runpath_origin ; echo
Hello, I'm library B.

mkdir -p test
cd test ; ../uselib/uselib_rpath          ; echo
../uselib/uselib_rpath: error while loading shared libraries: libmylib.so: cannot open shared object file: No such fi
le or directory

cd test ; ../uselib/uselib_runpath_rel    ; echo
../uselib/uselib_runpath_rel: error while loading shared libraries: libmylib.so: cannot open shared object file: No s
uch file or directory

cd test ; ../uselib/uselib_runpath_abs    ; echo
Hello, I'm library A.

cd test ; ../uselib/uselib_runpath_origin ; echo
Hello, I'm library A.
```


## 参考

[rpath vs runpath](https://medium.com/obscure-system/rpath-vs-runpath-883029b17c45)
