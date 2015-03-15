//
//  AppController.m
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

#import "AppController.h"
#import "OpticalImage.h"
#import "StatExtensions.h"

#include <CoreFoundation/CoreFoundation.h>
#include <IOKit/IOKitLib.h>



@implementation AppController

@synthesize  processAcessoryView;
@synthesize  fractionText, infoText, filename;
@synthesize  progress;
@synthesize  progressPanel, startingTime;




- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}



- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)theApplication
{
    return NO;
}



- (IBAction)createSignalCSVFile:(id)sender
{
    NSError *error = nil;
    
    NSOpenPanel* openDialog = [NSOpenPanel openPanel];
    
    [openDialog setTitle:@"Choose Directory"];
    [openDialog setMessage:@"Choose direcory with the files to be used."];
    [openDialog setCanChooseFiles:NO];
    [openDialog setCanChooseDirectories:YES];
    [openDialog setAllowsMultipleSelection: NO];
    [openDialog setAllowedFileTypes: [NSArray arrayWithObject: @"optdata"]];
    
    if ([openDialog runModal] != NSFileHandlingPanelOKButton)
        return;
    
    NSURL * dirURL = [[openDialog URLs] objectAtIndex: 0];
    
    NSDirectoryEnumerator *enumerator = 
        [[NSFileManager defaultManager]
            enumeratorAtURL:dirURL
            includingPropertiesForKeys:nil
            options:(NSDirectoryEnumerationSkipsPackageDescendants |
                     NSDirectoryEnumerationSkipsHiddenFiles)
            errorHandler:^(NSURL *url, NSError *error)
                {
                    return YES;
                }
         ];
    
    NSString * dataTable = @"";

    for (NSURL * url in enumerator)
    {
        if([[url lastPathComponent] hasSuffix: @"optdata"])
        {
            NSLog(@"Processing: %@", [url lastPathComponent]);
            
            NSString * line = @"";
            NSDictionary * dict = [NSDictionary dictionaryWithContentsOfURL: url];
            NSString * animal_id = [dict objectForKey: @"animal.id"];
            NSString * stimulus_type = [dict objectForKey: @"stimulus.type"];
            NSString * signals = [dict objectForKey: @"signal.data"];
            
            line = [line stringByAppendingString: animal_id];
            line = [line stringByAppendingString: @",\t"];
            line = [line stringByAppendingString: stimulus_type];
            line = [line stringByAppendingString: @",\t"];
            line = [line stringByAppendingString: signals];
            line = [line stringByAppendingString: @"\n"];
        
            dataTable = [dataTable stringByAppendingString: line];
        }
    }
    
    if(dataTable == nil)
    {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"No files"];
        [alert setInformativeText:@"No optdata files were found in the selected directory. No output was generated."];
        [alert setAlertStyle:NSWarningAlertStyle];
        
        if ([alert runModal] == NSAlertFirstButtonReturn)
        {
            
        }
        return;
    }

    // Write to file
    
    NSURL * statURL = [dirURL URLByAppendingPathComponent: @"Signal.csv"];
    [dataTable writeToURL: statURL atomically:YES encoding: NSUnicodeStringEncoding error:&error];
}



- (IBAction)createStatisticsCSVFile:(id)sender
{
    NSError *error = nil;
    
    NSOpenPanel* openDialog = [NSOpenPanel openPanel];
    
    [openDialog setTitle:@"Choose Directory"];
    [openDialog setMessage:@"Choose direcory with the files to be used for the statistics."];
    [openDialog setCanChooseFiles:NO];
    [openDialog setCanChooseDirectories:YES];
    [openDialog setAllowsMultipleSelection: NO];
//  [openDialog setAllowedFileTypes: [NSArray arrayWithObject: @"optdata"]];
    
    if ([openDialog runModal] != NSFileHandlingPanelOKButton)
        return;
    
    NSURL * dirURL = [[openDialog URLs] objectAtIndex: 0];
    
    NSDirectoryEnumerator *enumerator = 
        [[NSFileManager defaultManager]
            enumeratorAtURL:dirURL
            includingPropertiesForKeys:nil
            options:(NSDirectoryEnumerationSkipsPackageDescendants |
                     NSDirectoryEnumerationSkipsHiddenFiles)
            errorHandler:^(NSURL *url, NSError *error)
                {
                    return YES;
                }
         ];
    
    NSString * separator = @", ";
    NSURL * firstURL = nil;
    NSArray * headings = nil;
    NSString * dataTable = nil;
    BOOL first = YES;

    for (NSURL * url in enumerator)
    {
        if([[url lastPathComponent] hasSuffix: @"optdata"])
        {
            NSLog(@"Processing: %@", [url lastPathComponent]);
            if(first)
            {
                firstURL = url;
                headings = [[NSDictionary dictionaryWithContentsOfURL: firstURL] allKeys];
                dataTable = [[headings componentsJoinedByString: separator] stringByAppendingString: @"\n"];
                first = NO;
            }
            
            NSString * line = @"";
            NSDictionary * dict = [NSDictionary dictionaryWithContentsOfURL: url];
            for(int h=0; h<headings.count; h++)
            {
                NSString * k = [headings objectAtIndex: h];
                NSString * v = [dict objectForKey: k];
                if(v == nil)
                    v = @"";
                line = [line stringByAppendingString: v];
                if(h==headings.count-1)
                    line = [line stringByAppendingString: @"\n"];
                else
                    line = [line stringByAppendingString: separator];
            
            }
            dataTable = [dataTable stringByAppendingString: line];
        }
    }
    
    if(dataTable == nil)
    {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"No files"];
        [alert setInformativeText:@"No optdata files were found in the selected directory. No output was generated."];
        [alert setAlertStyle:NSWarningAlertStyle];
        
        if ([alert runModal] == NSAlertFirstButtonReturn)
        {
            
        }
        
 //       [alert release];
        return;
    }

    // Write to file
    
    NSURL * statURL = [dirURL URLByAppendingPathComponent: @"Statistics.csv"];
    [dataTable writeToURL: statURL atomically:YES encoding: NSUnicodeStringEncoding error:&error];
}



- (IBAction)clearAllCalculations:(id)sender
{
    NSError *error = nil;
    
    NSOpenPanel* openDialog = [NSOpenPanel openPanel];
    
    [openDialog setTitle:@"Choose Directory"];
    [openDialog setMessage:@"Choose direcory where the calculated data should be removed."];
    [openDialog setCanChooseFiles:NO];
    [openDialog setCanChooseDirectories:YES];
    [openDialog setAllowsMultipleSelection: NO];
    
    if ([openDialog runModal] != NSFileHandlingPanelOKButton)
        return;
    
    NSURL * dirURL = [[openDialog URLs] objectAtIndex: 0];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSDirectoryEnumerator *enumerator = 
    [fileManager enumeratorAtURL:dirURL
     includingPropertiesForKeys:nil
     options:(NSDirectoryEnumerationSkipsPackageDescendants |
              NSDirectoryEnumerationSkipsHiddenFiles)
     errorHandler:^(NSURL *url, NSError *error)
     {
         return YES;
     }
     ];
    
    for (NSURL * url in enumerator)
    {
        if([[url lastPathComponent] hasSuffix: @"optdata"])
        {
            if (![fileManager removeItemAtURL: url error:&error])
            {
                // Handle the error.
            }
        }
    }
}



-(void)calculateROCCurveForParamaters: (NSDictionary *)params
{
    NSDirectoryEnumerator *enumerator =
        [[NSFileManager defaultManager]
            enumeratorAtURL:directoryURL
            includingPropertiesForKeys:nil
            options:(NSDirectoryEnumerationSkipsPackageDescendants |
                     NSDirectoryEnumerationSkipsHiddenFiles)
            errorHandler:^(NSURL *url, NSError *error)
                {
                    return YES;
                }
         ];
    
    int c = 0;
    for (NSURL * url in enumerator)
        if([[url lastPathComponent] hasSuffix: @"optdata"])
            c++;
    
    double value[c];
    int label[c];
    int animal[c];
    int count = 0;
    int max_animal = 0;
    
    enumerator =
        [[NSFileManager defaultManager]
            enumeratorAtURL:directoryURL
            includingPropertiesForKeys:nil
            options:(NSDirectoryEnumerationSkipsPackageDescendants |
                     NSDirectoryEnumerationSkipsHiddenFiles)
            errorHandler:^(NSURL *url, NSError *error)
                {
                    return YES;
                }
         ];

    // Read values
    
    for (NSURL * url in enumerator)
    {
        if([[url lastPathComponent] hasSuffix: @"optdata"])
        {
            NSDictionary * dict = [NSDictionary dictionaryWithContentsOfURL: url];

            {
                if([[dict objectForKey: [params objectForKey: @"label.column"]] isEqualToString: [params objectForKey: @"label1"]])
                {
                    value[count] = [[dict objectForKey: [params objectForKey: @"value.column"]] doubleValue];
                    animal[count] = [[dict objectForKey: @"animal.id"] intValue];
                    if(animal[count] > max_animal)
                        max_animal = animal[count];
                    label[count] = 0;
                    count++;
            
                }
                else if([[dict objectForKey: [params objectForKey: @"label.column"]] isEqualToString: [params objectForKey: @"label2"]])
                {
                    value[count] = [[dict objectForKey: [params objectForKey: @"value.column"]] doubleValue];
                    animal[count] = [[dict objectForKey: @"animal.id"] intValue];
                    if(animal[count] > max_animal)
                        max_animal = animal[count];
                    label[count] = 1;
                    count++;
                }
            }
        }
    }

    // Normalize over each animal
    
    BOOL normalize = [[params objectForKey: @"normalize"] boolValue];
    
    if(normalize)
    {
        for(int i=0; i<=max_animal; i++)
        {
            NSMutableArray * v = [NSMutableArray arrayWithCapacity: 100];
            for(int j=0; j<count; j++)
                if(animal[j] == i)
                    [v addObject: [NSNumber numberWithDouble: value[j]]];
        
            NSDictionary * sd = [v statisticsWithCategory: @""];
            
            double median = [[sd objectForKey:@"median"] doubleValue];
            double q1 = [[sd objectForKey:@"q1"] doubleValue];
            double q3 = [[sd objectForKey:@"q3"] doubleValue];
            double d = ((q3-median)+(median-q1))/2.0f;

            if(d != 0)
                for(int j=0; j<count; j++)
                    if(animal[j] == i)
                        value[j] = (value[j]-median)/d;
        }
    }
    
    // Aggregate multiple measurements
    
    BOOL aggregate = [[params objectForKey: @"aggregate"] boolValue];
    
    if(aggregate)
    {
            float c1[max_animal];
            float c2[max_animal];
            float n1[max_animal];
            float n2[max_animal];
            
            for(int i=0; i<=max_animal; i++)
            {
                c1[i] = 0;
                c2[i] = 0;
                n1[i] = 0;
                n2[i] = 0;
            }
            
            for(int i=0; i<count; i++)
            {
                if(label[i] == 0)
                {
                    c1[animal[i]] += value[i];
                    n1[animal[i]] += 1;
                }
                else
                {
                    c2[animal[i]] += value[i];
                    n2[animal[i]] += 1;
                }
            }
            
            int j=0;
            for(int i=0; i<max_animal; i++)
            {
                if(n1[i] > 0)
                {
                    value[j] = c1[i]/n1[i];
                    label[j] = 0;
                    j++;
                }
                
                if(n2[i] > 0)
                {
                    value[j] = c2[i]/n2[i];
                    label[j] = 1;
                    j++;
                }
            }
         
            count = j;
    }

    int    P = 0;
    int    N = 0;

    for(int j=0; j<count; j++)
        if(label[j] == 1)
            P++;
        else
            N++;

    if(P == 0 || N == 0)
        return;
    
    // Sort
    
    bool flag;
    int n = count;
    do
    {
        flag = false;
        for(int i=1; i<count; i++)
            if(value[i-1] > value[i])
            {
                double v = value[i];
                int l = label[i];
                value[i] = value[i-1];
                label[i] = label[i-1];
                value[i-1] = v;
                label[i-1] = l;
                flag = true;
            }
        n--;
    }
    while(flag);
    
    double x_last = 0;
    double y_last = 0;
    double AUC = 0.0;

    NSString * line = @"";
    
    line = [line stringByAppendingString: [NSString stringWithFormat: @"%lf,%lf\n", 0.0, 0.0]];
        
    for(int i=count-1; i>=0; i--)
    {
        int    TP = 0;
        int    FP = 0;

        double threshold = value[i];
        for(int j=0; j<count; j++)
            if(value[j]>=threshold)
            {
                if(label[j] == 1)
                    TP++;
                else
                    FP++;
            }
        
        double x = (double)TP/(double)P;
        double y = (double)FP/(double)N;

        AUC += 0.5*(x-x_last)*(y+y_last);

        if(x != x_last || y != y_last)
            line = [line stringByAppendingString: [NSString stringWithFormat: @"%lf,%lf\n", x, y]];

        x_last = x;
        y_last = y;
    }

    AUC += 0.5*(1.0-x_last)*(1.0+y_last);
    
    if(1.0 != x_last || 1.0 != y_last)
        line = [line stringByAppendingString: [NSString stringWithFormat: @"%lf,%lf\n", 1.0, 1.0]];
    line = [line stringByAppendingString: [NSString stringWithFormat: @"\nAUC =,%lf\n", AUC]];
    
    NSError * error;
    NSURL * statURL = [directoryURL URLByAppendingPathComponent: [NSString stringWithFormat:@"ROC.%@.csv", [params objectForKey: @"value.column"]]];
    [line writeToURL: statURL atomically:YES encoding: NSUnicodeStringEncoding error:&error];
}



-(void)calculateROCCurves
{
    NSURL * url = [directoryURL URLByAppendingPathComponent: @"ROC.plist"];
    NSArray * roc_list = [NSArray arrayWithContentsOfURL: url];
    
    if(roc_list == NULL)
        return;
    
    for(NSDictionary * dict in roc_list)
    {
        NSLog(@"ROC for with categories %@:%@", [dict objectForKey: @"label1"], [dict objectForKey: @"label2"]);
        
        [self calculateROCCurveForParamaters: dict];
    }
}



- (void)setProcessedFile:(NSString *)fileName
{
    [filename setStringValue: fileName];
}



- (void)advanceProgress:(NSString *)fileName
{
    [progress setIndeterminate: NO];
    [progress incrementBy: 1.0];
    remainingFiles--;
    [infoText setStringValue: [NSString stringWithFormat: @"Processing %d Optical Imaging Files", remainingFiles]];
    [fractionText setStringValue: @""];
    
    NSTimeInterval now = -[startingTime timeIntervalSinceNow];
    double timeLeft = remainingFiles*(now/(numberOfFiles-remainingFiles));
    
    if(timeLeft > 60)
        [fractionText setStringValue: [NSString stringWithFormat: @"Approximately %.0lf minutes", timeLeft/60.0]];
    else
        [fractionText setStringValue: [NSString stringWithFormat: @"Approximately %.0lf seconds", timeLeft]];
}



- (void)processingComplete:(id)none
{
    [[NSSound soundNamed:@"Ping.aiff"] play];
    
    [fractionText setStringValue: @"Calculating ROC curves"];
    
    [self calculateROCCurves];

    [progressPanel close];
}



- (void)processFiles: (NSDirectoryEnumerator *)enumerator
{
    for (NSURL * url in enumerator)
    {
        if([[url lastPathComponent] hasSuffix: @"tif"])
        {
            [self performSelectorOnMainThread:@selector(setProcessedFile:) withObject: [url lastPathComponent] waitUntilDone:NO];
            (void)[[OpticalImage alloc] initWithTIFF: url usingTemplate: YES];
            [self performSelectorOnMainThread:@selector(advanceProgress:) withObject: [url lastPathComponent] waitUntilDone:NO];
        }
        if(batchCancelled)
            break;
    }
    [self performSelectorOnMainThread:@selector(processingComplete:) withObject: nil waitUntilDone:NO];
}



volatile int ccc = 0;



- (void)processFilesConcurrently: (NSDirectoryEnumerator *)enumerator
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    for (NSURL * url in enumerator)
    {
        while(ccc > 12)
            ;
        
         NSLog(@"Waiting: %d", ccc);
        
        if([[url lastPathComponent] hasSuffix: @"tif"])
        {
            NSLog(@"operation starting: %d", ++ccc);
            dispatch_group_async(group, queue, ^{
                [self performSelectorOnMainThread:@selector(setProcessedFile:) withObject: [url lastPathComponent] waitUntilDone:NO];
                (void)[[OpticalImage alloc] initWithTIFF: url usingTemplate: YES];
                [self performSelectorOnMainThread:@selector(advanceProgress:) withObject: [url lastPathComponent] waitUntilDone:NO];
                 NSLog(@"operation completed: %d", --ccc);
            });
        
        }
        if(batchCancelled)
            break;
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_release(group);
    [self performSelectorOnMainThread:@selector(processingComplete:) withObject: nil waitUntilDone:NO];
}




- (IBAction)batchProcess:(id)sender
{
    NSOpenPanel* openDialog = [NSOpenPanel openPanel];
    
    [openDialog setTitle:@"Choose Directory"];
    [openDialog setMessage:@"Choose direcory with the files to be processed."];
    [openDialog setCanChooseFiles:NO];
    [openDialog setCanChooseDirectories:YES];
    [openDialog setAllowsMultipleSelection: NO];
    
    if ([openDialog runModal] != NSFileHandlingPanelOKButton)
        return;
    
    batchCancelled = NO;

    [progressPanel makeKeyAndOrderFront:self];
    [progress setIndeterminate:YES];
    [progress startAnimation: self];
    
    directoryURL = [[openDialog URLs] objectAtIndex: 0];
    
    NSDirectoryEnumerator *enumerator = 
    [[NSFileManager defaultManager]
     enumeratorAtURL:directoryURL
     includingPropertiesForKeys:nil
     options:(NSDirectoryEnumerationSkipsPackageDescendants |
              NSDirectoryEnumerationSkipsHiddenFiles)
     errorHandler:^(NSURL *url, NSError *error)
     {
         return YES;
     }
     ];

    NSDirectoryEnumerator *enumeratorForCounting = 
    [[NSFileManager defaultManager]
     enumeratorAtURL:directoryURL
     includingPropertiesForKeys:nil
     options:(NSDirectoryEnumerationSkipsPackageDescendants |
              NSDirectoryEnumerationSkipsHiddenFiles)
     errorHandler:^(NSURL *url, NSError *error)
     {
         return YES;
     }
     ];
    
    // Count files
    
    int c = 0;
    for (NSURL * url in enumeratorForCounting)
        if([[url lastPathComponent] hasSuffix: @"tif"])
            c++;
    
    numberOfFiles = c;
    remainingFiles = c;
    startingTime = [NSDate date];
    
    [infoText setStringValue: [NSString stringWithFormat: @"Processing %d Optical Imaging Files", remainingFiles]];
    [fractionText setStringValue: @""];
    [progress setMaxValue: (double)c];
    [progress setDoubleValue: 0.0];
     
    // Detach processing threads
    
    [NSThread detachNewThreadSelector:@selector(processFilesConcurrently:) toTarget:self withObject:enumerator];
 }



- (IBAction)cancelBatch:(id)sender
{
    batchCancelled = YES;
    [infoText setStringValue: @"Waiting for operation to stop…"];
    [progress setIndeterminate: YES];
    [progress startAnimation: self];
}




@end
