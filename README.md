# @date/holidays-us
[![Build Status](https://travis-ci.org/elidoran/node-date-holidays-us.svg?branch=master)](https://travis-ci.org/elidoran/node-date-holidays-us)
[![Dependency Status](https://gemnasium.com/elidoran/node-date-holidays-us.png)](https://gemnasium.com/elidoran/node-date-holidays-us)
[![npm version](https://badge.fury.io/js/%40date%2Fholidays-us.svg)](http://badge.fury.io/js/%40date%2Fholidays-us)

A `@date/holidays` instance with USA public and bank holidays.

Also has functions to calculate dates for specific holidays.

## Install

```sh
npm install @date/holidays-us --save
```

## Usage

```javascript
// get Holidays instance with both public and bank holidays
var holidays = require('@date/holidays-us')

var date = new Date(2016, 0, 1) // New Year's Day 2016
holidays.isHoliday(date) // true

date.setDate(10) // January 10th 2016
holidays.isHoliday(date) // false

date = holidays.thanksgiving(2015) // November 26th, 2015
date = holidays.thanksgiving(2016) // November 24th, 2016

date = holidays.valentinesDay(2016) // February 14th, 2016
holidays.isHoliday(date) // true, it's a holiday

// this will return false because Valentine's Day isn't a bank holiday
holidays.isHoliday(date, {
  // only consider it a holiday when the properties in this object match
  bank:true // must be a bank holiday
})
```


## Only Bank Holidays

```javascript
// this has only the bank holidays, not the 'public' ones
var holidays = require('@date/holidays-us').bank()

// returns false, Valentine's isn't a bank holiday
holidays.isHoliday(new Date(2016, 1, 14))

// returns true, New Year's is a bank holiday
holidays.isHoliday(new Date(2016, 0, 1))
```


## Only Public Holidays

```javascript
// this has only the non-bank holidays
var holidays = require('@date/holidays-us').public()

// returns true, Valentine's is a public holiday
holidays.isHoliday(new Date(2016, 1, 14))

// returns false, because New Year's is a bank holiday
holidays.isHoliday(new Date(2016, 0, 1))

// NOTE: technically, I suppose the bank holidays are also
// public holidays, but, if you want both, use the default
// instance which has both
```


## API: Generators

Functions which generate a specific holiday based on a specified year:

1. newYearsDay() - can calculate observed holiday as well
2. valentinesDay()
3. martinLutherKingDay()
4. presidentsDay()
6. mothersDay()
7. memorialDay()
8. fathersDay()
9. independenceDay() - can calculate observed holiday as well
10. laborDay()
11. columbusDay()
12. halloween()
13. veteransDay() - can calculate observed holiday as well
14. thanksgiving()
15. christmas() - can calculate observed holiday as well

## API: Observed Holidays

Some holidays are "observed" on a different day than the holiday. The generate functions can calculate that as well.

```javascript
var holidays = require('@date/holidays-us')

// Christmas in 2016 is on a Sunday so it is "observed" the next day, Monday.
// the call to the generator returns the date instance as expected
var christmasDay = holidays.christmas(2016) // same as new Date(2016, 11, 25)
// it also has an `observed` property containing the "observed" holiday date
// Note: if there is no "observed" holiday then `observed` is undefined
var observedChristmas = date.observed

// christmas         == new Date(2016, 11, 25) Sunday, December 25th 2016
// observedChristmas == new Date(2016, 11, 26) Monday, December 26th 2016
```

## MIT License
