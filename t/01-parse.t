#!/usr/bin/perl

use strict;
use warnings;

use DateTime::Format::Natural;
use DateTime::Format::Natural::Test ':set';
use Test::More;

my @simple = (
    { 'now'                            => '24.11.2006 01:13:08'     },
    { 'yesterday'                      => '23.11.2006 00:00:00'     },
    { 'today'                          => '24.11.2006 00:00:00'     },
    { 'tomorrow'                       => '25.11.2006 00:00:00'     },
    { 'morning'                        => '24.11.2006 08:00:00'     },
    { 'afternoon'                      => '24.11.2006 14:00:00'     },
    { 'evening'                        => '24.11.2006 20:00:00'     },
    { 'noon'                           => '24.11.2006 12:00:00'     },
    { 'midnight'                       => '24.11.2006 00:00:00'     },
    { 'yesterday {at} noon'            => '23.11.2006 12:00:00'     },
    { 'yesterday {at} midnight'        => '23.11.2006 00:00:00'     },
    { 'today {at} noon'                => '24.11.2006 12:00:00'     },
    { 'today {at} midnight'            => '24.11.2006 00:00:00'     },
    { 'tomorrow {at} noon'             => '25.11.2006 12:00:00'     },
    { 'tomorrow {at} midnight'         => '25.11.2006 00:00:00'     },
    { 'this morning'                   => '24.11.2006 08:00:00'     },
    { 'this afternoon'                 => '24.11.2006 14:00:00'     },
    { 'this evening'                   => '24.11.2006 20:00:00'     },
    { 'yesterday morning'              => '23.11.2006 08:00:00'     },
    { 'yesterday afternoon'            => '23.11.2006 14:00:00'     },
    { 'yesterday evening'              => '23.11.2006 20:00:00'     },
    { 'today morning'                  => '24.11.2006 08:00:00'     },
    { 'today afternoon'                => '24.11.2006 14:00:00'     },
    { 'today evening'                  => '24.11.2006 20:00:00'     },
    { 'tomorrow morning'               => '25.11.2006 08:00:00'     },
    { 'tomorrow afternoon'             => '25.11.2006 14:00:00'     },
    { 'tomorrow evening'               => '25.11.2006 20:00:00'     },
    { 'thursday morning'               => '23.11.2006 08:00:00'     },
    { 'thursday afternoon'             => '23.11.2006 14:00:00'     },
    { 'thursday evening'               => '23.11.2006 20:00:00'     },
    { '6:00{sec} yesterday'            => '23.11.2006 06:00:{sec}'  },
    { '6:00{sec} today'                => '24.11.2006 06:00:{sec}'  },
    { '6:00{sec} tomorrow'             => '25.11.2006 06:00:{sec}'  },
    { '5{min_sec}{ }am yesterday'      => '23.11.2006 05:{min_sec}' },
    { '5{min_sec}{ }am today'          => '24.11.2006 05:{min_sec}' },
    { '5{min_sec}{ }am tomorrow'       => '25.11.2006 05:{min_sec}' },
    { '4{min_sec}{ }pm yesterday'      => '23.11.2006 16:{min_sec}' },
    { '4{min_sec}{ }pm today'          => '24.11.2006 16:{min_sec}' },
    { '4{min_sec}{ }pm tomorrow'       => '25.11.2006 16:{min_sec}' },
    { 'last second'                    => '24.11.2006 01:13:07'     },
    { 'this second'                    => '24.11.2006 01:13:08'     },
    { 'next second'                    => '24.11.2006 01:13:09'     },
    { 'last minute'                    => '24.11.2006 01:12:00'     },
    { 'this minute'                    => '24.11.2006 01:13:00'     },
    { 'next minute'                    => '24.11.2006 01:14:00'     },
    { 'last hour'                      => '24.11.2006 00:00:00'     },
    { 'this hour'                      => '24.11.2006 01:00:00'     },
    { 'next hour'                      => '24.11.2006 02:00:00'     },
    { 'last day'                       => '23.11.2006 00:00:00'     },
    { 'this day'                       => '24.11.2006 00:00:00'     },
    { 'next day'                       => '25.11.2006 00:00:00'     },
    { 'last week'                      => '17.11.2006 00:00:00'     },
    { 'this week'                      => '24.11.2006 00:00:00'     },
    { 'next week'                      => '01.12.2006 00:00:00'     },
    { 'last month'                     => '01.10.2006 00:00:00'     },
    { 'this month'                     => '01.11.2006 00:00:00'     },
    { 'next month'                     => '01.12.2006 00:00:00'     },
    { 'last year'                      => '01.01.2005 00:00:00'     },
    { 'this year'                      => '01.01.2006 00:00:00'     },
    { 'next year'                      => '01.01.2007 00:00:00'     },
    { 'last friday'                    => '17.11.2006 00:00:00'     },
    { 'this friday'                    => '24.11.2006 00:00:00'     },
    { 'next friday'                    => '01.12.2006 00:00:00'     },
    { 'tuesday last week'              => '14.11.2006 00:00:00'     },
    { 'tuesday this week'              => '21.11.2006 00:00:00'     },
    { 'tuesday next week'              => '28.11.2006 00:00:00'     },
    { 'last week wednesday'            => '15.11.2006 00:00:00'     },
    { 'this week wednesday'            => '22.11.2006 00:00:00'     },
    { 'next week wednesday'            => '29.11.2006 00:00:00'     },
    { '10 seconds ago'                 => '24.11.2006 01:12:58'     },
    { '10 minutes ago'                 => '24.11.2006 01:03:08'     },
    { '10 hours ago'                   => '23.11.2006 15:13:08'     },
    { '10 days ago'                    => '14.11.2006 01:13:08'     },
    { '10 weeks ago'                   => '15.09.2006 01:13:08'     },
    { '10 months ago'                  => '24.01.2006 01:13:08'     },
    { '10 years ago'                   => '24.11.1996 01:13:08'     },
    { 'in 5 seconds'                   => '24.11.2006 01:13:13'     },
    { 'in 5 minutes'                   => '24.11.2006 01:18:08'     },
    { 'in 5 hours'                     => '24.11.2006 06:13:08'     },
    { 'in 5 days'                      => '29.11.2006 01:13:08'     },
    { 'in 5 weeks'                     => '29.12.2006 01:13:08'     },
    { 'in 5 months'                    => '24.04.2007 01:13:08'     },
    { 'in 5 years'                     => '24.11.2011 01:13:08'     },
    { 'saturday'                       => '25.11.2006 00:00:00'     },
    { 'yesterday {at} 4:00{sec}'       => '23.11.2006 04:00:{sec}'  },
    { 'today {at} 4:00{sec}'           => '24.11.2006 04:00:{sec}'  },
    { 'tomorrow {at} 4:00{sec}'        => '25.11.2006 04:00:{sec}'  },
    { 'yesterday {at} 6:45{sec}{ }am'  => '23.11.2006 06:45:{sec}'  },
    { 'today {at} 6:45{sec}{ }am'      => '24.11.2006 06:45:{sec}'  },
    { 'tomorrow {at} 6:45{sec}{ }am'   => '25.11.2006 06:45:{sec}'  },
    { 'yesterday {at} 6:45{sec}{ }pm'  => '23.11.2006 18:45:{sec}'  },
    { 'today {at} 6:45{sec}{ }pm'      => '24.11.2006 18:45:{sec}'  },
    { 'tomorrow {at} 6:45{sec}{ }pm'   => '25.11.2006 18:45:{sec}'  },
    { 'wednesday {at} 14:30{sec}'      => '22.11.2006 14:30:{sec}'  },
    { 'wednesday {at} 02:30{sec}{ }am' => '22.11.2006 02:30:{sec}'  },
    { 'wednesday {at} 02:30{sec}{ }pm' => '22.11.2006 14:30:{sec}'  },
    { '2nd monday'                     => '13.11.2006 00:00:00'     },
    { '100th day'                      => '10.04.2006 00:00:00'     },
    { '4th february'                   => '04.02.2006 00:00:00'     },
    { 'november 3rd'                   => '03.11.2006 00:00:00'     },
    { 'last june'                      => '01.06.2005 00:00:00'     },
    { 'next october'                   => '01.10.2007 00:00:00'     },
    { '5{min_sec}{ }am'                => '24.11.2006 05:{min_sec}' },
    { '5:30{sec}{ }am'                 => '24.11.2006 05:30:{sec}'  },
    { '4{min_sec}{ }pm'                => '24.11.2006 16:{min_sec}' },
    { '4:20{sec}{ }pm'                 => '24.11.2006 16:20:{sec}'  },
    { '06:56:06{ }am'                  => '24.11.2006 06:56:06'     },
    { '06:56:06{ }pm'                  => '24.11.2006 18:56:06'     },
    { 'mon 2:35{sec}'                  => '20.11.2006 02:35:{sec}'  },
    { '1:00{sec} sun'                  => '26.11.2006 01:00:{sec}'  },
    { '1{min_sec}{ }am sun'            => '26.11.2006 01:{min_sec}' },
    { '1{min_sec}{ }pm sun'            => '26.11.2006 13:{min_sec}' },
    { '1:00{sec} on sun'               => '26.11.2006 01:00:{sec}'  },
    { '1{min_sec}{ }am on sun'         => '26.11.2006 01:{min_sec}' },
    { '1{min_sec}{ }pm on sun'         => '26.11.2006 13:{min_sec}' },
    { '12:14{sec}{ }PM'                => '24.11.2006 12:14:{sec}'  },
    { '12:14{sec}{ }AM'                => '24.11.2006 00:14:{sec}'  },
);

my @complex = (
    { 'yesterday 7 seconds ago'                    => '23.11.2006 01:13:01'     },
    { 'yesterday 7 minutes ago'                    => '23.11.2006 01:06:08'     },
    { 'yesterday 7 hours ago'                      => '22.11.2006 18:13:08'     },
    { 'yesterday 7 days ago'                       => '16.11.2006 00:00:00'     },
    { 'yesterday 7 weeks ago'                      => '05.10.2006 00:00:00'     },
    { 'yesterday 7 months ago'                     => '23.04.2006 00:00:00'     },
    { 'yesterday 7 years ago'                      => '23.11.1999 00:00:00'     },
    { 'today 5 seconds ago'                        => '24.11.2006 01:13:03'     },
    { 'today 5 minutes ago'                        => '24.11.2006 01:08:08'     },
    { 'today 5 hours ago'                          => '23.11.2006 20:13:08'     },
    { 'today 5 days ago'                           => '19.11.2006 00:00:00'     },
    { 'today 5 weeks ago'                          => '20.10.2006 00:00:00'     },
    { 'today 5 months ago'                         => '24.06.2006 00:00:00'     },
    { 'today 5 years ago'                          => '24.11.2001 00:00:00'     },
    { 'tomorrow 3 seconds ago'                     => '25.11.2006 01:13:05'     },
    { 'tomorrow 3 minutes ago'                     => '25.11.2006 01:10:08'     },
    { 'tomorrow 3 hours ago'                       => '24.11.2006 22:13:08'     },
    { 'tomorrow 3 days ago'                        => '22.11.2006 00:00:00'     },
    { 'tomorrow 3 weeks ago'                       => '04.11.2006 00:00:00'     },
    { 'tomorrow 3 months ago'                      => '25.08.2006 00:00:00'     },
    { 'tomorrow 3 years ago'                       => '25.11.2003 00:00:00'     },
    { '2 seconds before now'                       => '24.11.2006 01:13:06'     },
    { '2 minutes before now'                       => '24.11.2006 01:11:08'     },
    { '2 hours before now'                         => '23.11.2006 23:13:08'     },
    { '2 days before now'                          => '22.11.2006 01:13:08'     },
    { '2 weeks before now'                         => '10.11.2006 01:13:08'     },
    { '2 months before now'                        => '24.09.2006 01:13:08'     },
    { '2 years before now'                         => '24.11.2004 01:13:08'     },
    { '4 seconds from now'                         => '24.11.2006 01:13:12'     },
    { '4 minutes from now'                         => '24.11.2006 01:17:08'     },
    { '4 hours from now'                           => '24.11.2006 05:13:08'     },
    { '4 days from now'                            => '28.11.2006 01:13:08'     },
    { '4 weeks from now'                           => '22.12.2006 01:13:08'     },
    { '4 months from now'                          => '24.03.2007 01:13:08'     },
    { '4 years from now'                           => '24.11.2010 01:13:08'     },
    { '6 in the morning'                           => '24.11.2006 06:00:00'     },
    { '4 in the afternoon'                         => '24.11.2006 16:00:00'     },
    { '9 in the evening'                           => '24.11.2006 21:00:00'     },
    { 'monday 6 in the morning'                    => '20.11.2006 06:00:00'     },
    { 'monday 4 in the afternoon'                  => '20.11.2006 16:00:00'     },
    { 'monday 9 in the evening'                    => '20.11.2006 21:00:00'     },
    { 'monday last week'                           => '13.11.2006 00:00:00'     },
    { '6th day last week'                          => '18.11.2006 00:00:00'     },
    { '6th day this week'                          => '25.11.2006 00:00:00'     },
    { '6th day next week'                          => '02.12.2006 00:00:00'     },
    { '12th day last month'                        => '12.10.2006 00:00:00'     },
    { '12th day this month'                        => '12.11.2006 00:00:00'     },
    { '12th day next month'                        => '12.12.2006 00:00:00'     },
    { '1st day last year'                          => '01.01.2005 00:00:00'     },
    { '1st day this year'                          => '01.01.2006 00:00:00'     },
    { '1st day next year'                          => '01.01.2007 00:00:00'     },
    { '1st tuesday last november'                  => '01.11.2005 00:00:00'     },
    { '1st tuesday this november'                  => '07.11.2006 00:00:00'     },
    { '1st tuesday next november'                  => '06.11.2007 00:00:00'     },
    { '11 january next year'                       => '11.01.2007 00:00:00'     },
    { '11 january this year'                       => '11.01.2006 00:00:00'     },
    { '11 january last year'                       => '11.01.2005 00:00:00'     },
    { '6 hours before yesterday'                   => '22.11.2006 18:00:00'     },
    { '6 hours before tomorrow'                    => '24.11.2006 18:00:00'     },
    { '3 hours after yesterday'                    => '23.11.2006 03:00:00'     },
    { '3 hours after tomorrow'                     => '25.11.2006 03:00:00'     },
    { '10 hours before noon'                       => '24.11.2006 02:00:00'     },
    { '10 hours before midnight'                   => '23.11.2006 14:00:00'     },
    { '5 hours after noon'                         => '24.11.2006 17:00:00'     },
    { '5 hours after midnight'                     => '24.11.2006 05:00:00'     },
    { 'noon last friday'                           => '17.11.2006 12:00:00'     },
    { 'midnight last friday'                       => '17.11.2006 00:00:00'     },
    { 'noon this friday'                           => '24.11.2006 12:00:00'     },
    { 'midnight this friday'                       => '24.11.2006 00:00:00'     },
    { 'noon next friday'                           => '01.12.2006 12:00:00'     },
    { 'midnight next friday'                       => '01.12.2006 00:00:00'     },
    { 'last friday {at} 20:00{sec}'                => '17.11.2006 20:00:{sec}'  },
    { 'this friday {at} 20:00{sec}'                => '24.11.2006 20:00:{sec}'  },
    { 'next friday {at} 20:00{sec}'                => '01.12.2006 20:00:{sec}'  },
    { '1:00{sec} last friday'                      => '17.11.2006 01:00:{sec}'  },
    { '1:00{sec} this friday'                      => '24.11.2006 01:00:{sec}'  },
    { '1:00{sec} next friday'                      => '01.12.2006 01:00:{sec}'  },
    { '1{min_sec}{ }am last friday'                => '17.11.2006 01:{min_sec}' },
    { '1{min_sec}{ }am this friday'                => '24.11.2006 01:{min_sec}' },
    { '1{min_sec}{ }am next friday'                => '01.12.2006 01:{min_sec}' },
    { '1{min_sec}{ }pm last friday'                => '17.11.2006 13:{min_sec}' },
    { '1{min_sec}{ }pm this friday'                => '24.11.2006 13:{min_sec}' },
    { '1{min_sec}{ }pm next friday'                => '01.12.2006 13:{min_sec}' },
    { 'last wednesday {at} 7{min_sec}{ }am'        => '15.11.2006 07:{min_sec}' },
    { 'this wednesday {at} 7{min_sec}{ }am'        => '22.11.2006 07:{min_sec}' },
    { 'next wednesday {at} 7{min_sec}{ }am'        => '29.11.2006 07:{min_sec}' },
    { 'last wednesday {at} 7{min_sec}{ }pm'        => '15.11.2006 19:{min_sec}' },
    { 'this wednesday {at} 7{min_sec}{ }pm'        => '22.11.2006 19:{min_sec}' },
    { 'next wednesday {at} 7{min_sec}{ }pm'        => '29.11.2006 19:{min_sec}' },
    { '2nd friday in august'                       => '11.08.2006 00:00:00'     },
    { '3rd wednesday in november'                  => '15.11.2006 00:00:00'     },
    { 'tomorrow 1 year ago'                        => '25.11.2005 00:00:00'     },
    { 'saturday 3 months ago {at} 17:00{sec}'      => '26.08.2006 17:00:{sec}'  },
    { 'saturday 3 months ago {at} 5:00{sec}{ }am'  => '26.08.2006 05:00:{sec}'  },
    { 'saturday 3 months ago {at} 5:00{sec}{ }pm'  => '26.08.2006 17:00:{sec}'  },
    { '11 january 2 years ago'                     => '11.01.2004 00:00:00'     },
    { '4th day last week'                          => '16.11.2006 00:00:00'     },
    { '8th month last year'                        => '01.08.2005 00:00:00'     },
    { '8th month this year'                        => '01.08.2006 00:00:00'     },
    { '8th month next year'                        => '01.08.2007 00:00:00'     },
    { '6 mondays from now'                         => '01.01.2007 00:00:00'     },
    { 'fri 3 months ago at 5{min_sec}{ }am'        => '25.08.2006 05:{min_sec}' },
    { 'wednesday 1 month ago at 8{min_sec}{ }pm'   => '25.10.2006 20:{min_sec}' },
    { 'final thursday in april'                    => '27.04.2006 00:00:00'     },
    { 'final sunday in april'                      => '30.04.2006 00:00:00'     }, # edge case
    { 'last thursday in april'                     => '27.04.2006 00:00:00'     },
    { 'beginning of last month'                    => '01.10.2006 00:00:00'     },
    { 'end of last month'                          => '31.10.2006 00:00:00'     },
);

my @specific = (
    { 'march'                              => '01.03.2006 00:00:00'     },
    { 'january 11'                         => '11.01.2006 00:00:00'     },
    { '11 january'                         => '11.01.2006 00:00:00'     },
    { '18 oct {at} 17:00{sec}'             => '18.10.2006 17:00:{sec}'  },
    { '18 oct 2001 {at} 17:00{sec}'        => '18.10.2001 17:00:{sec}'  },
    { '18 oct {at} 5{min_sec}{ }am'        => '18.10.2006 05:{min_sec}' },
    { '18 oct {at} 5{min_sec}{ }pm'        => '18.10.2006 17:{min_sec}' },
    { 'dec 25'                             => '25.12.2006 00:00:00'     },
    { 'feb 28 {at} 3:00{sec}'              => '28.02.2006 03:00:{sec}'  },
    { 'feb 28 2001 {at} 3:00{sec}'         => '28.02.2001 03:00:{sec}'  },
    { 'feb 28 {at} 3{min_sec}{ }am'        => '28.02.2006 03:{min_sec}' },
    { 'feb 28 {at} 3{min_sec}{ }pm'        => '28.02.2006 15:{min_sec}' },
    { '19:00{sec} jul 1'                   => '01.07.2006 19:00:{sec}'  },
    { '7{min_sec}{ }am jul 1'              => '01.07.2006 07:{min_sec}' },
    { '7{min_sec}{ }pm jul 1'              => '01.07.2006 19:{min_sec}' },
    { 'jan 24, 2011 {at} 12:00{sec}'       => '24.01.2011 12:00:{sec}'  },
    { 'jan 24, 2011 {at} 12{min_sec}{ }am' => '24.01.2011 00:{min_sec}' },
    { 'jan 24, 2011 {at} 12{min_sec}{ }pm' => '24.01.2011 12:{min_sec}' },
    { 'may 27th'                           => '27.05.2006 00:00:00'     },
  # { '2005'                               => '01.01.2005 00:00:00'     },
    { 'march 1st 2009'                     => '01.03.2009 00:00:00'     },
    { 'October 2006'                       => '01.10.2006 00:00:00'     },
    { 'february 14, 2004'                  => '14.02.2004 00:00:00'     },
    { 'jan 3 2010'                         => '03.01.2010 00:00:00'     },
    { 'jan 3 2010 {at} 17:23'              => '03.01.2010 17:23:00'     },
    { 'jan 3 2010 {at} 5{min_sec}{ }pm'    => '03.01.2010 17:{min_sec}' },
    { '3 jan 2000'                         => '03.01.2000 00:00:00'     },
    { '3 jan 2000 {at} 03:02'              => '03.01.2000 03:02:00'     },
    { '3 jan 2000 {at} 3{min_sec}{ }am'    => '03.01.2000 03:{min_sec}' },
    { '2010 october 28'                    => '28.10.2010 00:00:00'     },
    { '27/5/1979'                          => '27.05.1979 00:00:00'     },
    { '6'                                  => '24.11.2006 06:00:00'     },
    { '4:00'                               => '24.11.2006 04:00:00'     },
    { '17:00'                              => '24.11.2006 17:00:00'     },
    { '3:20:00'                            => '24.11.2006 03:20:00'     },
    { '-5min'                              => '24.11.2006 01:08:08'     },
    { '+2d'                                => '26.11.2006 01:13:08'     },
);

_run_tests(666, [ [ \@simple ], [ \@complex ], [ \@specific ] ], \&compare);

sub compare
{
    my $aref = shift;

    foreach my $href (@$aref) {
        my $key = (keys %$href)[0];
        foreach my $entry ($time_entries->($key, $href->{$key})) {
            foreach my $string ($case_strings->($entry->[0])) {
                compare_strings($string, $entry->[1]);
            }
        }
    }
}

sub compare_strings
{
    my ($string, $result) = @_;

    my $parser = DateTime::Format::Natural->new;
    $parser->_set_datetime(\%time);

    my $dt = $parser->parse_datetime($string);

    if ($parser->success) {
        is(_result_string($dt), $result, _message($string));
    }
    else {
        fail(_message($string));
    }
}
