//
//  StatExtensions.m
//  
//
//    Copyright (C) 2012-2015  Anna Balkenius & Christian Balkenius
//
//    This program is free software; you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation; either version 2 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program; if not, write to the Free Software
//    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//

#import "StatExtensions.h"


@implementation NSArray (StatExtensions)

-(double)mean
{
    double s = 0;
    double n = (double)[self count];
    if(n == 0)
        return 0;
    for(NSNumber * v in self)
        s += [v doubleValue];
    return s/n;
}



-(double)median
{
    NSArray * a = [self sortedArrayUsingSelector:@selector(compare:)];
    int n = [a count];
    if(n % 2 == 1)
        return [[a objectAtIndex: (n-1)/2] doubleValue];
    else
        return 0.5*([[a objectAtIndex: (n-1)/2] doubleValue] + [[a objectAtIndex: (n+1)/2] doubleValue]);
}



-(NSDictionary *)statisticsWithCategory: (NSString *)category
{
    NSArray * a = [self sortedArrayUsingSelector:@selector(compare:)];
    int n = [a count];

    if(n == 0)
    {
        return nil; // Return dictionary later with all values at zero
    }
    
    double min = [[self objectAtIndex: 0] doubleValue];
    double max = min;
    double sum = 0;
    for(NSNumber * v in self)
    {
        double val = [v doubleValue];
        sum += val;
        if(val > max)
            max = val;
        else if(val < min)
            min = val;
    }
    double mean = sum/n;

    double stdev = 0;
    if(n > 1)
    {
        for(NSNumber * v in self)
            stdev += ([v doubleValue]-mean) * ([v doubleValue]-mean);
        stdev /= n; // (n-1)
        stdev = sqrt(stdev);
    }

    double median;
    if(n % 2 == 1)
        median = [[a objectAtIndex: (n-1)/2] doubleValue];
    else
        median = 0.5*([[a objectAtIndex: (n-1)/2] doubleValue] + [[a objectAtIndex: (n+1)/2] doubleValue]);

    double q1 = [[a objectAtIndex: (int)(0.25*(double)n-0.5)] doubleValue];
    double q3 = [[a objectAtIndex: (int)(0.75*(double)n-0.5)] doubleValue];
    
    // Find whisker positions
    
    double uW = q3+1.5*(q3-q1);
    double upper_whisker = max;
    int uWi = self.count-1;
    while(upper_whisker > uW && uWi>0)
    {
        upper_whisker = [[a objectAtIndex:uWi] doubleValue];
        uWi--;
    }
    
    double lW = q1-1.5*(q3-q1);
    double lower_whisker = min;
    int lWi = 0;
    while(lower_whisker < lW && lWi<self.count)
    {
        lower_whisker = [[a objectAtIndex:lWi] doubleValue];
        lWi++;
    }

    NSDictionary * dict = [NSDictionary 
        dictionaryWithObjects: [NSArray arrayWithObjects:
            category,
            [NSNumber numberWithDouble: n],
            [NSNumber numberWithDouble: min],
            [NSNumber numberWithDouble: max],
            [NSNumber numberWithDouble: median],
            [NSNumber numberWithDouble: q1],
            [NSNumber numberWithDouble: q3],
            [NSNumber numberWithDouble: mean],
            [NSNumber numberWithDouble: stdev],
            [NSNumber numberWithDouble: upper_whisker],
            [NSNumber numberWithDouble: lower_whisker],
            a,
            nil]
                                                        
        forKeys: [NSArray arrayWithObjects: 
            @"category",
            @"n",
            @"min",
            @"max",
            @"median",
            @"q1",
            @"q3",
            @"mean",
            @"stdev",
            @"upper_whisker",
            @"lower_whisker",
            @"data",
            nil]
    ];

    return dict;
}

@end
