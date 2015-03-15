//
//  AppController.h
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

@interface AppController : NSObject  <NSApplicationDelegate>
{
    NSView * processAcessoryView;
    NSTextField * fractionText;
    NSTextField * infoText;
    NSTextField * filename;
    NSProgressIndicator * progress;
    NSPanel * progressPanel;
    BOOL batchCancelled;
    int numberOfFiles;
    int remainingFiles;
    NSDate * startingTime;
    NSURL * directoryURL;
}

@property (nonatomic, retain) IBOutlet NSView * processAcessoryView;
@property (nonatomic, retain) IBOutlet NSTextField * fractionText;
@property (nonatomic, retain) IBOutlet NSTextField * infoText;
@property (nonatomic, retain) IBOutlet NSTextField * filename;
@property (nonatomic, retain) IBOutlet NSProgressIndicator * progress;
@property (nonatomic, retain) IBOutlet NSPanel * progressPanel;
@property (nonatomic, retain) NSDate * startingTime;

- (IBAction)createSignalCSVFile:(id)sender;
- (IBAction)createStatisticsCSVFile:(id)sender;
- (IBAction)batchProcess:(id)sender;
- (IBAction)cancelBatch:(id)sender;
- (IBAction)clearAllCalculations:(id)sender;

- (void)advanceProgress:(NSString *)fileName;

@end

