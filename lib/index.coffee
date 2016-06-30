gen = require('@date/generator')()

# create a Holidays instance to setup
holidays = require('@date/holidays')()

holidays.newYearsDay = (year) ->
  date = new Date year, 0, 1 # january 1st

  switch date.getDay()

    # # bank holiday and no observed holiday
    # when 1, 2, 3, 4, 5

    when 0 # not a bank holiday, observe it the next day (monday)
      date.observed = new Date year, 0, 2

    when 6 # then it's on a saturday, not a bank holiday, observed on friday
      date.observed = new Date (year - 1), 11, 31

  return date

holidays.valentinesDay = (year) -> new Date year, 1, 14

holidays.martinLutherKingDay = (year) -> gen.third().monday().january year

holidays.presidentsDay = (year) -> gen.third().monday().february year

holidays.mothersDay = (year) -> gen.second().sunday().may year

holidays.memorialDay = (year) -> gen.last().monday().may year

holidays.fathersDay = (year) -> gen.third().sunday().june year

holidays.independenceDay = (year) ->
  date = new Date year, 6, 4 # july 4th

  switch date.getDay()

    # # bank holiday and no observed holiday
    # when 1, 2, 3, 4, 5

    when 0 # not a bank holiday, observe it the next day (monday)
      date.observed = new Date year, 6, 5

    when 6 # then it's on a saturday, not a bank holiday, observed on friday
      date.observed = new Date year, 6, 3

  return date

holidays.laborDay = (year) -> gen.first().monday().september year

holidays.columbusDay = (year) -> gen.second().monday().october year

holidays.halloween = (year) -> new Date year, 10, 31

holidays.veteransDay = (year) ->
  date = new Date year, 10, 11 # november 11th

  switch date.getDay()

    # # bank holiday and no observed holiday
    # when 1, 2, 3, 4, 5, 6

    when 0 # not a bank holiday, observe it the next day (monday)
      date.observed = new Date year, 10, 12

  return date

holidays.thanksgiving = (year) -> gen.fourth().thursday().november year

holidays.christmas = (year) ->
  date = new Date year, 11, 25 # december 25th

  switch date.getDay()

    # # bank holiday and no observed holiday
    # when 1, 2, 3, 4, 5

    when 0 # not a bank holiday, observe it the next day (monday)
      date.observed = new Date year, 11, 26

    when 6 # then it's on a saturday, not a bank holiday, observed on friday
      date.observed = new Date year, 11, 24

  return date


pushHolidayFromDate = (array, date, info, observedInfo) ->

  array.push
    info: info
    date:
      month: date.getMonth()
      day  : date.getDate()

  if date.observed?
    array.push
      info: observedInfo
      date:
        month: date.observed.getMonth()
        day  : date.observed.getDate()

  return

# use one generator to add the usual holidays
holidays.add (year) ->

  holidayArray = []

  date = holidays.newYearsDay year
  info = name: 'New Year\'s Day', bank: true
  observedInfo = name: 'New Year\'s Day (Observed)', bank: true
  pushHolidayFromDate holidayArray, date, info, observedInfo

  date = holidays.valentinesDay year
  info = name: 'Valentine\'s Day', public: true
  pushHolidayFromDate holidayArray, date, info

  date = holidays.martinLutherKingDay year
  info = name: 'Martin Luther King Jr. Day', bank: true
  pushHolidayFromDate holidayArray, date, info

  date = holidays.presidentsDay year # Washington's Birthday...
  info = name: 'President\'s Day', bank: true
  observedInfo = name: 'President\'s Day (Observed)', bank: true
  pushHolidayFromDate holidayArray, date, info, observedInfo

  date = holidays.mothersDay year
  info = name: 'Mother\'s Day', public: true
  pushHolidayFromDate holidayArray, date, info

  date = holidays.memorialDay year
  info = name: 'Memorial Day', bank: true
  observedInfo = name: 'Memorial Day (Observed)', bank: true
  pushHolidayFromDate holidayArray, date, info, observedInfo

  date = holidays.fathersDay year
  info = name: 'Father\'s Day', public: true
  pushHolidayFromDate holidayArray, date, info

  date = holidays.independenceDay year
  info = name: 'Independence Day', bank: true
  observedInfo = name: 'Independence Day (Observed)', bank: true
  pushHolidayFromDate holidayArray, date, info, observedInfo

  date = holidays.laborDay year
  info = name: 'Labor Day', bank: true
  observedInfo = name: 'Labor Day (Observed)', bank: true
  pushHolidayFromDate holidayArray, date, info, observedInfo

  date = holidays.columbusDay year
  info = name: 'Columbus Day', bank: true
  observedInfo = name: 'Columbus Day (Observed)', bank: true
  pushHolidayFromDate holidayArray, date, info, observedInfo

  date = holidays.halloween year
  info = name: 'Halloween', public: true
  pushHolidayFromDate holidayArray, date, info

  date = holidays.veteransDay year
  info = name: 'Veterans Day'
  if date.getDay() isnt 6 then info.bank = true
  observedInfo = name: 'Veterans Day (Observed)', bank: true
  pushHolidayFromDate holidayArray, date, info, observedInfo

  date = holidays.thanksgiving year
  info = name: 'Thanksgiving Day', bank: true
  pushHolidayFromDate holidayArray, date, info

  date = holidays.christmas year
  info = name: 'Christmas Day', bank: true
  observedInfo = name: 'Christmas Day (Observed)', bank: true
  pushHolidayFromDate holidayArray, date, info, observedInfo

  return holidayArray


module.exports = holidays
