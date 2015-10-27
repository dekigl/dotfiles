# dotfiles

## 各種設定ファイル置き場
.emacs.d/init.d や .bash_profileなど
ここのファイルをsymlinkして使う

## emacsの場合：

    cd ~/.emacs.d
    ln -s ../dotfiles/emacs/init.el .

init.elにはpackage.plとinit-loader.elの設定しかない。
個々のelisp読み込みとかは、emacs/inits/に、起動時に読み込む処理をファイル個別で入れておく。
init-loader.elの使い方は以下を参考にした。
<http://qiita.com/catatsuy/items/5f1cd86e2522fd3384a0>
