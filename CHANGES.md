0.2.0 - 2016/06/30

1. removed "observed" from holidays which don't have them (copy-paste mistake)
2. correct assigning "bank:true" only when the holiday is a weekday
3. separate holiday generator into *public* and *bank* holiday generators
4. provide all by default, add two subfunctions to provide them individually
5. updated testing to match above changes
6. corrected Halloween which was using month 10 instead of 9 (Date's months are -1)

0.1.0 - 2016/06/30

1. initial working version with tests
