// TODO:
//  should I store all the consistent holiday info objects for reuse?
//  For example, all the fixed date holidays and the observed holidays
//  have the same info every time. It would store a lot less data overall...
//  the variable date holidays only have two info's to store: weekday/weekend.
//  Does anyone build up a lot of years of holidays?
//  Or, do they only maintain the one they're working with and purge others?
//  hmm. I personally work with the current year and sometimes span into another.
//  And I'm using it in scripts which run and then exit.
//  any feedback on this is welcome.

// TODO: ??
//  put the holiday date calculating functions each in their own package?
//  then they can be used separately from this package...
//  can then have this package depend on them and use them.

// TODO:
//  need a way so they can override the holiday info's.
//  should handle this in @date/holidays

// use `gen` to calculate holiday dates.
var gen = require('@date/generator')()

// use to build default instance and in exported convenience functions.
var Holidays = require('@date/holidays')

// create a default Holidays instance to setup and export.
var holidays = Holidays()

// export a default instance with all the holiday generators.
module.exports = holidays

// add both generators to the default instance.
holidays.add(generateBankHolidays)
holidays.add(generatePublicHolidays)

// add convenience function to provide a Holidays instance with
// only the bank holidays generator.
holidays.bank = function() {
  var bankHolidays = Holidays()
  bankHolidays.add(generateBankHolidays)
  // TODO: add the individual holiday date calculators ...?
  return bankHolidays
}

// add convenience function to provide a Holidays instance with
// only the public holidays generator.
holidays.public = function() {
  var publicHolidays = Holidays()
  publicHolidays.add(generatePublicHolidays)
  // TODO: add the individual holiday date calculators ...?
  return publicHolidays
}


/*
 * Add holiday date calculating functions to the instance so they're
 * available individually.
 * These are used in the generator functions as well.
 */

holidays.newYearsDay = function(year) {
  var date = new Date(year, 0, 1) // january 1st

  // add `observed` date if it's a weekend day.
  switch (date.getDay()) {

    // when 1, 2, 3, 4, 5 - bank holiday and no observed holiday
    case 0: // not a bank holiday, observe it the next day (monday).
      date.observed = new Date(year, 0, 2)
      break

    case 6: // then it's on a saturday, not a bank holiday, observed on friday.
      date.observed = new Date(year - 1, 11, 31)
      break
  }

  return date
}

holidays.valentinesDay = function(year) {
  // easy, it's always the same date every year.
  return new Date(year, 1, 14)
}

holidays.martinLutherKingDay = function(year) {
  return gen.third().monday().january(year)
}

holidays.presidentsDay = function(year) {
  return gen.third().monday().february(year)
}

holidays.easter = function(year) {
  // implementation of anonymous gregorian algorithm
  var L, a, b, c, d, date, day, e, f, g, h, i, k, m, month
  a = year % 19
  b = Math.floor(year / 100)
  c = year % 100
  d = Math.floor(b / 4)
  e = b % 4
  f = Math.floor((b + 8) / 25)
  g = Math.floor((b - f + 1) / 3)
  h = (19 * a + b - d - g + 15) % 30
  i = Math.floor(c / 4)
  k = c % 4
  L = (32 + 2 * e + 2 * i - h - k) % 7
  m = Math.floor((a + 11 * h + 22 * L) / 451)
  month = Math.floor(((h + L - 7 * m + 114) / 31) - 1)
  day = ((h + L - 7 * m + 114) % 31) + 1
  date = new Date(year, month, day)
  return date
}

holidays.mothersDay = function(year) {
  return gen.second().sunday().may(year)
}

holidays.memorialDay = function(year) {
  return gen.last().monday().may(year)
}

holidays.fathersDay = function(year) {
  return gen.third().sunday().june(year)
}

holidays.independenceDay = function(year) {
  var date = new Date(year, 6, 4) // july 4th

  switch (date.getDay()) {

    // when 1, 2, 3, 4, 5 - bank holiday and no observed holiday.
    case 0: // not a bank holiday, observe it the next day (monday).
      date.observed = new Date(year, 6, 5)
      break
    case 6: // then it's on a saturday, not a bank holiday, observed on friday.
      date.observed = new Date(year, 6, 3)
      break
  }

  return date
}

holidays.laborDay = function(year) {
  return gen.first().monday().september(year)
}

holidays.columbusDay = function(year) {
  return gen.second().monday().october(year)
}

holidays.halloween = function(year) {
  return new Date(year, 9, 31)
}

holidays.veteransDay = function(year) {
  var date = new Date(year, 10, 11) // november 11th

  // add `observed` date if it's a Sunday.
  switch (date.getDay()) {

    // when 1, 2, 3, 4, 5 - bank holiday and no observed holiday.
    case 0: // not a bank holiday, observe it the next day (monday).
      date.observed = new Date(year, 10, 12)
      break
  }

  return date
}

holidays.thanksgiving = function(year) {
  return gen.fourth().thursday().november(year)
}

holidays.christmas = function(year) {
  var date = new Date(year, 11, 25) // december 25th

  // add `observed` date if it's a weekend day.
  switch (date.getDay()) {

    // when 1, 2, 3, 4, 5 - bank holiday and no observed holiday.
    case 0: // not a bank holiday, observe it the next day (monday).
      date.observed = new Date(year, 11, 26)
      break

    case 6: // then it's on a saturday, not a bank holiday, observed on friday.
      date.observed = new Date(year, 11, 24)
      break
  }

  return date
}


// helper function which accepts the calculated holiday date and holiday info's.
// if an observed date was produced then it returns both holidays.
// also helps with the `bank` boolean value.
function makeHoliday(date, info, observedInfo) {

  // always make the holiday.
  var holiday = {
    info: info,
    date: {
      month: date.getMonth(),
      day  : date.getDate()
    }
  }

  // if the holiday info's `bank` value has a function then
  // give it the date so it can evaluate the value.
  if ('function' === typeof info.bank) {
    info.bank = info.bank(date)
  }

  // without an observed holiday we return only the main holiday
  if (date.observed == null) {
    return holiday
  }

  // there's an observed date so return both holidays in an array.
  else {
    return [
      holiday, // main holiday
      {        // observed holiday
        info: observedInfo,
        date: {
          month: date.observed.getMonth(),
          day  : date.observed.getDate()
        }
      }
    ]
  }
}

// a "@date/holidays generator function".
// it accepts the year and uses it to calculate all the "public" holidays.
function generatePublicHolidays(year) {

  // return array of generated holidays
  return [
    makeHoliday(
      holidays.valentinesDay(year),
      { name: 'Valentine\'s Day', public: true }
    ),

    makeHoliday(
      holidays.easter(year),
      { name: 'Easter', bank: false }
    ),

    makeHoliday(
      holidays.mothersDay(year),
      { name: 'Mother\'s Day', public: true }
    ),

    makeHoliday(
      holidays.fathersDay(year),
      { name: 'Father\'s Day', public: true }
    ),

    makeHoliday(
      holidays.halloween(year),
      { name: 'Halloween', public: true }
    )
  ]
}

// helper for holidays with a possible observed date.
// their "is bank holiday" value depends on whether it's a weekday.
function isWeekday(date) {
  var day = date.getDay()
  return 0 < day && day < 6
}

// a "@date/holidays generator function".
// it accepts the year and uses it to calculate all the "bank" holidays.
function generateBankHolidays(year) {

  // return array of generated holidays
  return [

    newYearsSpecial(year),

    makeHoliday(
      holidays.martinLutherKingDay(year),
      { name: 'Martin Luther King Jr. Day', bank: true }
    ),

    makeHoliday(
      holidays.presidentsDay(year), // Washington's Birthday...
      { name: 'President\'s Day', bank: isWeekday },
      { name: 'President\'s Day (Observed)', bank: true }
    ),

    makeHoliday(
      holidays.memorialDay(year),
      { name: 'Memorial Day', bank: true }
    ),

    makeHoliday(
      holidays.independenceDay(year),
      { name: 'Independence Day', bank: isWeekday },
      { name: 'Independence Day (Observed)', bank: true }
    ),

    makeHoliday(
      holidays.laborDay(year),
      { name: 'Labor Day', bank: true }
    ),

    makeHoliday(
      holidays.columbusDay(year),
      { name: 'Columbus Day', bank: true }
    ),

    makeHoliday(
      holidays.veteransDay(year),
      { name: 'Veterans Day', bank: isWeekday },
      { name: 'Veterans Day (Observed)', bank: true }
    ),

    makeHoliday(
      holidays.thanksgiving(year),
      { name: 'Thanksgiving Day', bank: true }
    ),

    makeHoliday(
      holidays.christmas(year),
      { name: 'Christmas Day', bank: isWeekday },
      { name: 'Christmas Day (Observed)', bank: true }
    )
  ]
}

// The New Year's holiday can have an observed date in the previous year.
// That messes with the whole "generate and cache holidays by year" thing.
// This handles it by identifying when that happens and specifying the custom year.
// The @date/holidays package handles the custom year as of v0.3.1.
function newYearsSpecial(year) {

  // 1. hold onto the date, we'll need it in #3
  var date = holidays.newYearsDay(year)

  // 2. do the usual.
  var newYears = makeHoliday(
    date,
    { name: 'New Year\'s Day', bank: !date.observed },
    { name: 'New Year\'s Day (Observed)', bank: true }
  )

  // 3. check if the observed date is in the previous year...
  if (date.observed && date.observed.getFullYear() < year) {
    // specify that year in the observed holiday's date.
    newYears[1].date.year = year - 1
  }

  return newYears
}
