# UltimateDoomBuilder.github.io

This is the repository that provides minimal UI to download latest UDB, as well as serving as the auto-update backend.

When new versions are added to `files`, the recommended way to update this repository is something like:

```
$ cd ./build
$ python ./build_from_template.py
$ cd ..
$ git add .
$ git commit -a --amend
$ git push -f
```