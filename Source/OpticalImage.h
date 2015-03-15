//
//  OpticalImage.h
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

#import <Cocoa/Cocoa.h>

@interface OpticalImage : NSObject <NSTableViewDataSource>
{
    NSURL * tiffURL;
    NSURL * dictionaryURL;
    NSURL * pointsURL;
    
    NSMutableDictionary * data;
    NSMutableDictionary * points;

    NSImage * sourceTIFF;

    NSImage * averageImage;

    double * activityHistogram;
    double activityHistogramMax;

    NSString * prefix;
    
    // regression parameters
    
    double * alpha;
    double * beta;
    
    // Low-level data store
    
    int size_x;
    int size_y;
    int count;
    
    float *** image;
    float *** smooth_image;
    float **  mask_image;
    float *** regression_image;
    float *** signal_image;
    
    float *   image_curve;
    float *   regression_curve;
    float *   signal_curve;

    float **  image_curve_in_point;
    float **  regression_curve_in_point;
    float **  signal_curve_in_point;
}


@property int size_x;
@property int size_y;
@property int count;


@property (nonatomic, retain) NSURL * tiffURL;
@property (nonatomic, retain) NSURL * dictionaryURL;
@property (nonatomic, retain) NSURL * pointsURL;

@property (nonatomic, retain) NSMutableDictionary * data;

@property (nonatomic, retain) NSImage * sourceTIFF;
@property (nonatomic, retain) NSImage * averageImage;

@property float *   image_curve;
@property float *   regression_curve;
@property float *   signal_curve;

@property float **  image_curve_in_point;
@property float **  regression_curve_in_point;
@property float **  signal_curve_in_point;

@property double * activityHistogram;
@property double activityHistogramMax;

- (id)initWithTIFF: (NSURL *)fileURL usingTemplate: (BOOL)useTemplate;

- (void)calculatePseudoLevels;

- (void)calculateMask;
- (void)process;
- (void)processUsingTemplate;
- (void)clear;
- (void)saveData;

- (void)addPoint:(int)p atX:(double)x andY:(double)y;
- (void)removePointAtX:(double)x andY:(double)y;

- (NSPoint)point:(int)p;
- (void)removeAllPoints;
- (void)loadPoints;

- (NSBitmapImageRep *)createMaskImage;
- (NSBitmapImageRep *)createPseudocolorImage: (int)frame;

@end

