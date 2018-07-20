### 0.4.0 - 2018/07/20

1. update deps
2. switch to JS from CS (except tests)
3. move to node 6+
4. add testing scripts for multiple node versions
5. add code coverage
6. remove gemnasium badge
7. add coveralls badge
8. update tests for 100% code coverage
9. have TravisCI test nodes 6, 8, and 10


### 0.3.0 - 2016/07/22

1. accepted PR from @water42 with easter() implementation
2. split generator into two groups: 1. bank; 2. public.
3. added functions to use one group or the other instead of both

### 0.2.0 - 2016/06/30

1. removed "observed" from holidays which don't have them (copy-paste mistake)
2. correct assigning "bank:true" only when the holiday is a weekday
3. separate holiday generator into *public* and *bank* holiday generators
4. provide all by default, add two subfunctions to provide them individually
5. updated testing to match above changes
6. corrected Halloween which was using month 10 instead of 9 (Date's months are -1)

### 0.1.0 - 2016/06/30

1. initial working version with tests
