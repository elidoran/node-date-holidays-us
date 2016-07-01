assert = require 'assert'
holidays  = require '../../lib'

tests = [
  { # without observed day
    name: 'newYearsDay'
    main:
      info: name: 'New Year\'s Day', bank: true
      year: 2016
      month: 0
      day: 1
  }
  { # with observed day
    name: 'newYearsDay'
    main:
      info: name: 'New Year\'s Day'
      year: 2017
      month: 0
      day: 1
    observed:
      info: name: 'New Year\'s Day (Observed)', bank: true
      year: 2017
      month: 0
      day: 2
  }

  {
    name: 'martinLutherKingDay'
    main:
      info: name: 'Martin Luther King Jr. Day', bank: true
      year: 2017
      month: 0
      day: 16
  }

  {
    name: 'valentinesDay'
    main:
      info: name: 'Valentine\'s Day', public: true
      year: 2016
      month: 1
      day: 14
  }

  {
    name: 'presidentsDay'
    main:
      info: name: 'President\'s Day', bank: true
      year: 2016
      month: 1
      day: 15
  }

  {
      name: 'easter'
      main:
        info: name: 'Easter', bank: false
        year: 2016
        month: 2
        day: 27
  }

  {
    name: 'mothersDay'
    main:
      info: name: 'Mother\'s Day', public: true
      year: 2016
      month: 4
      day: 8
  }

  {
    name: 'memorialDay'
    main:
      info: name: 'Memorial Day', bank: true
      year: 2016
      month: 4
      day: 30
  }

  {
    name: 'fathersDay'
    main:
      info: name: 'Father\'s Day', public: true
      year: 2016
      month: 5
      day: 19
  }

  { # without observed day
    name: 'independenceDay'
    main:
      info: name: 'Independence Day', bank: true
      year: 2016
      month: 6
      day: 4
  }
  { # with observed day
    name: 'independenceDay'
    main:
      info: name: 'Independence Day'
      year: 2015
      month: 6
      day: 4
    observed:
      info: name: 'Independence Day (Observed)', bank: true
      year: 2015
      month: 6
      day: 3
  }

  {
    name: 'laborDay'
    main:
      info: name: 'Labor Day', bank: true
      year: 2015
      month: 8
      day: 7
  }

  {
    name: 'columbusDay'
    main:
      info: name: 'Columbus Day', bank: true
      year: 2015
      month: 9
      day: 12
  }

  {
    name: 'halloween'
    main:
      info: name: 'Halloween', public: true
      year: 2015
      month: 9
      day: 31
  }

  { # without observed day, weekday
    name: 'veteransDay'
    main:
      info: name: 'Veterans Day', bank: true
      year: 2015
      month: 10
      day: 11 # wednesday
  }
  { # without observed day, saturday
    name: 'veteransDay'
    main:
      info: name: 'Veterans Day'
      year: 2017
      month: 10
      day: 11 # saturday
  }
  { # with observed day
    name: 'veteransDay'
    main:
      info: name: 'Veterans Day'
      year: 2012
      month: 10
      day: 11 # sunday
    observed:
      info: name: 'Veterans Day (Observed)', bank: true
      year: 2012
      month: 10
      day: 12 # monday
  }

  {
    name: 'thanksgiving'
    main:
      info: name: 'Thanksgiving Day', bank: true
      year: 2016
      month: 10
      day: 24
  }

  { # without observed day
    name: 'christmas'
    main:
      info: name: 'Christmas Day', bank: true
      year: 2015
      month: 11
      day: 25
  }
  { # with observed day
    name: 'christmas'
    main:
      info: name: 'Christmas Day'
      year: 2016
      month: 11
      day: 25
    observed:
      info: name: 'Christmas Day (Observed)', bank: true
      year: 2016
      month: 11
      day: 26
  }

]

describe 'test holidays-us', ->

  describe 'with non-holidays', ->

    it 'non-holiday for getHoliday() returns null', ->

      date = new Date 2016, 5, 4
      result = holidays.getHoliday date
      assert.equal result, null

    it 'non-holiday for isHoliday() returns false', ->

      date = new Date 2016, 5, 4
      result = holidays.isHoliday date
      assert.equal result, false

  describe 'with', ->

    bankHolidayDates = [
      { date: new Date(2016, 0, 1),   name: 'New Year\'s' }
      { date: new Date(2016, 0, 18),  name: 'Martin Luther King Jr. Day' }
      { date: new Date(2016, 1, 15),  name: 'President\'s Day' }
      { date: new Date(2016, 4, 30),  name: 'Memorial Day' }
      { date: new Date(2016, 6, 4),   name: 'Independence Day' }
      { date: new Date(2016, 8, 5),   name: 'Labor Day' }
      { date: new Date(2016, 9, 10),  name: 'Columbus Day' }
      { date: new Date(2016, 10, 11), name: 'Veterans Day' }
      { date: new Date(2016, 10, 24), name: 'Thanksgiving' }
      { date: new Date(2016, 11, 25), name: 'Christmas' }
      { date: new Date(2016, 11, 26), name: 'Christmas (Observed)' }
    ]

    publicHolidayDates = [
      { date: new Date(2016, 1, 14), name: 'Valentine\'s' }
      { date: new Date(2016, 4, 8),  name: 'Mother\'s Day' }
      { date: new Date(2016, 5, 19), name: 'Father\'s Day' }
      { date: new Date(2016, 9, 31), name: 'Halloween' }
    ]

    describe 'bank-only', ->

      bankHolidays = holidays.bank()

      it 'should have bank holidays', ->
        for test in bankHolidayDates
          assert.equal true, bankHolidays.isHoliday(test.date), test.name

      it 'shouldn\'t have public holidays', ->
        for test in publicHolidayDates
          assert.equal false, bankHolidays.isHoliday(test.date), test.name


    describe 'public-only', ->

      publicHolidays = holidays.public()

      it 'shouldn\'t have bank holidays', ->
        for test in bankHolidayDates
          assert.equal false, publicHolidays.isHoliday(test.date), test.name

      it 'should have public holidays', ->
        for test in publicHolidayDates
          assert.equal true, publicHolidays.isHoliday(test.date), test.name



  for test in tests

    do (test) ->

      describe test.main.info.name + (if test.observed? then ' (with Observed)' else ''), ->

        testDate = new Date(test.main.year, test.main.month, test.main.day)

        it 'direct function should return the date', ->

          date = holidays[test.name] test.main.year
          assert.equal date.getTime(), testDate.getTime()

        if test.observed?
          it 'the date has observed date attached', ->

            date = holidays[test.name] test.main.year
            observedDate = new Date test.observed.year, test.observed.month, test.observed.day
            assert.equal date.observed.getTime(), observedDate.getTime()

        it 'is available from getHoliday()', ->

          holiday = holidays.getHoliday testDate
          assert.deepEqual holiday, test.main.info

        if test.observed?
          it 'observed is available from getHoliday()', ->
            observedDate = new Date test.observed.year, test.observed.month, test.observed.day
            observedHoliday = holidays.getHoliday observedDate
            assert.deepEqual observedHoliday, test.observed.info

        it 'correct date for isHoliday() returns true', ->

          result = holidays.isHoliday testDate
          assert.equal result, true, 'correct date should return true'
