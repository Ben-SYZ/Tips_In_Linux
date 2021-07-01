```
$ false && echo abc || echo ab
return 0
$ false && echo abc
return 1
```

第二个因为不执行echo abc 所以会返回错误

