//
//  MainView.m
//  Optima 2
//
//  Created by Christian Balkenius on 2010-07-11.
//  Copyright 2010 Lund Univeristy Cognitive Science. All rights reserved.
//

#import "MainView.h"
#import "OpticalImage.h"

static int LUT_fire[256][3] =
{
    {0, 0, 31},
    {0, 0, 34},
    {0, 0, 38},
    {0, 0, 42},
    {0, 0, 46},
    {0, 0, 49},
    {0, 0, 53},
    {0, 0, 57},
    {0, 0, 61},
    {0, 0, 65},
    {0, 0, 69},
    {0, 0, 74},
    {0, 0, 78},
    {0, 0, 82},
    {0, 0, 87},
    {0, 0, 91},
    {1, 0, 96},
    {4, 0, 100},
    {7, 0, 104},
    {10, 0, 108},
    {13, 0, 113},
    {16, 0, 117},
    {19, 0, 121},
    {22, 0, 125},
    {25, 0, 130},
    {28, 0, 134},
    {31, 0, 138},
    {34, 0, 143},
    {37, 0, 147},
    {40, 0, 151},
    {43, 0, 156},
    {46, 0, 160},
    {49, 0, 165},
    {52, 0, 168},
    {55, 0, 171},
    {58, 0, 175},
    {61, 0, 178},
    {64, 0, 181},
    {67, 0, 185},
    {70, 0, 188},
    {73, 0, 192},
    {76, 0, 195},
    {79, 0, 199},
    {82, 0, 202},
    {85, 0, 206},
    {88, 0, 209},
    {91, 0, 213},
    {94, 0, 216},
    {98, 0, 220},
    {101, 0, 220},
    {104, 0, 221},
    {107, 0, 222},
    {110, 0, 223},
    {113, 0, 224},
    {116, 0, 225},
    {119, 0, 226},
    {122, 0, 227},
    {125, 0, 224},
    {128, 0, 222},
    {131, 0, 220},
    {134, 0, 218},
    {137, 0, 216},
    {140, 0, 214},
    {143, 0, 212},
    {146, 0, 210},
    {148, 0, 206},
    {150, 0, 202},
    {152, 0, 199},
    {154, 0, 195},
    {156, 0, 191},
    {158, 0, 188},
    {160, 0, 184},
    {162, 0, 181},
    {163, 0, 177},
    {164, 0, 173},
    {166, 0, 169},
    {167, 0, 166},
    {168, 0, 162},
    {170, 0, 158},
    {171, 0, 154},
    {173, 0, 151},
    {174, 0, 147},
    {175, 0, 143},
    {177, 0, 140},
    {178, 0, 136},
    {179, 0, 132},
    {181, 0, 129},
    {182, 0, 125},
    {184, 0, 122},
    {185, 0, 118},
    {186, 0, 114},
    {188, 0, 111},
    {189, 0, 107},
    {190, 0, 103},
    {192, 0, 100},
    {193, 0, 96},
    {195, 0, 93},
    {196, 1, 89},
    {198, 3, 85},
    {199, 5, 82},
    {201, 7, 78},
    {202, 8, 74},
    {204, 10, 71},
    {205, 12, 67},
    {207, 14, 64},
    {208, 16, 60},
    {209, 19, 56},
    {210, 21, 53},
    {212, 24, 49},
    {213, 27, 45},
    {214, 29, 42},
    {215, 32, 38},
    {217, 35, 35},
    {218, 37, 31},
    {220, 40, 27},
    {221, 43, 23},
    {223, 46, 20},
    {224, 48, 16},
    {226, 51, 12},
    {227, 54, 8},
    {229, 57, 5},
    {230, 59, 4},
    {231, 62, 3},
    {233, 65, 3},
    {234, 68, 2},
    {235, 70, 1},
    {237, 73, 1},
    {238, 76, 0},
    {240, 79, 0},
    {241, 81, 0},
    {243, 84, 0},
    {244, 87, 0},
    {246, 90, 0},
    {247, 92, 0},
    {249, 95, 0},
    {250, 98, 0},
    {252, 101, 0},
    {252, 103, 0},
    {252, 105, 0},
    {253, 107, 0},
    {253, 109, 0},
    {253, 111, 0},
    {254, 113, 0},
    {254, 115, 0},
    {255, 117, 0},
    {255, 119, 0},
    {255, 121, 0},
    {255, 123, 0},
    {255, 125, 0},
    {255, 127, 0},
    {255, 129, 0},
    {255, 131, 0},
    {255, 133, 0},
    {255, 134, 0},
    {255, 136, 0},
    {255, 138, 0},
    {255, 140, 0},
    {255, 141, 0},
    {255, 143, 0},
    {255, 145, 0},
    {255, 147, 0},
    {255, 148, 0},
    {255, 150, 0},
    {255, 152, 0},
    {255, 154, 0},
    {255, 155, 0},
    {255, 157, 0},
    {255, 159, 0},
    {255, 161, 0},
    {255, 162, 0},
    {255, 164, 0},
    {255, 166, 0},
    {255, 168, 0},
    {255, 169, 0},
    {255, 171, 0},
    {255, 173, 0},
    {255, 175, 0},
    {255, 176, 0},
    {255, 178, 0},
    {255, 180, 0},
    {255, 182, 0},
    {255, 184, 0},
    {255, 186, 0},
    {255, 188, 0},
    {255, 190, 0},
    {255, 191, 0},
    {255, 193, 0},
    {255, 195, 0},
    {255, 197, 0},
    {255, 199, 0},
    {255, 201, 0},
    {255, 203, 0},
    {255, 205, 0},
    {255, 206, 0},
    {255, 208, 0},
    {255, 210, 0},
    {255, 212, 0},
    {255, 213, 0},
    {255, 215, 0},
    {255, 217, 0},
    {255, 219, 0},
    {255, 220, 0},
    {255, 222, 0},
    {255, 224, 0},
    {255, 226, 0},
    {255, 228, 0},
    {255, 230, 0},
    {255, 232, 0},
    {255, 234, 0},
    {255, 235, 4},
    {255, 237, 8},
    {255, 239, 13},
    {255, 241, 17},
    {255, 242, 21},
    {255, 244, 26},
    {255, 246, 30},
    {255, 248, 35},
    {255, 248, 42},
    {255, 249, 50},
    {255, 250, 58},
    {255, 251, 66},
    {255, 252, 74},
    {255, 253, 82},
    {255, 254, 90},
    {255, 255, 98},
    {255, 255, 105},
    {255, 255, 113},
    {255, 255, 121},
    {255, 255, 129},
    {255, 255, 136},
    {255, 255, 144},
    {255, 255, 152},
    {255, 255, 160},
    {255, 255, 167},
    {255, 255, 175},
    {255, 255, 183},
    {255, 255, 191},
    {255, 255, 199},
    {255, 255, 207},
    {255, 255, 215},
    {255, 255, 223},
    {255, 255, 227},
    {255, 255, 231},
    {255, 255, 235},
    {255, 255, 239},
    {255, 255, 243},
    {255, 255, 247},
    {255, 255, 251},
    {255, 255, 255},
    {255, 255, 255},
    {255, 255, 255},
    {255, 255, 255},
    {255, 255, 255},
    {255, 255, 255},
    {255, 255, 255},
    {255, 255, 255}
};



@implementation MainView

@synthesize document;
@synthesize opticalImage;
@synthesize frameInView, frameCount;
@synthesize stepper;
@synthesize toolSelector;


/*
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        viewScale = 0;
    
        trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
            options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow )
            owner:self userInfo:nil];
        [self addTrackingArea:trackingArea];
    }
    return self;
}
*/


- (void)awakeFromNib
{
    viewScale = 0;

    trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
        options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow | NSTrackingCursorUpdate )
        owner:self userInfo:nil];
    [self addTrackingArea:trackingArea];
}



- (void)mouseEntered:(NSEvent *)theEvent
{
}



- (void)mouseExited:(NSEvent *)theEvent;
{

}



- (void)mouseMoved:(NSEvent *)theEvent;
{
    NSPoint event_location = [theEvent locationInWindow];
    NSPoint local_point = [self convertPoint:event_location fromView:nil];
}



-(void)cursorUpdate:(NSEvent *)theEvent
{
    NSImage * zIn = [NSImage imageNamed: @"zoom_in"];
    NSImage * zOut = [NSImage imageNamed: @"zoom_out"];

    switch([toolSelector selectedSegment])
    {
        case 1:
            [[[NSCursor alloc] initWithImage: zIn hotSpot: NSMakePoint(0,0)] set];
            break;
            
        case 2:
            [[[NSCursor alloc] initWithImage: zOut hotSpot: NSMakePoint(0,0)] set];
            break;
            break;

        case 0:
        case 3:
        case 4:
            [[NSCursor crosshairCursor] set];
            break;
            
        default:;
    }
}



- (void)mouseDown:(NSEvent *)theEvent
{
     switch([toolSelector selectedSegment])
    {
        case 0:
            // inpect point - do nothing for now
            break;
        
        case 1:
            viewScale += 1.0;
            [self setNeedsDisplay: YES];
            break;
            
        case 2:
            viewScale -= 1.0;
            [self setNeedsDisplay: YES];
            break;

         case 3:
            // set point
            {
                float scale = pow(2, viewScale);
                
                float imageHeight = scale*opticalImage.size_y;
                float imageWidth = scale*opticalImage.size_x;
                
                float viewHeight = self.bounds.size.height;
                float viewWidth = self.bounds.size.width;
                float x = (viewWidth-imageWidth)/2;
                float y = (viewHeight-imageHeight)/2;

                NSPoint q = [self convertPoint:[theEvent locationInWindow] fromView: nil];
                
                [opticalImage addPoint: [document.pointSelection indexOfSelectedItem]+1 atX: (q.x-x)/scale andY: (viewHeight-q.y-y)/scale];
                [document redraw: self];
            }
            break;
            
        case 4:
            // remove point
            {
                float scale = pow(2, viewScale);
                
                float imageHeight = scale*opticalImage.size_y;
                float imageWidth = scale*opticalImage.size_x;
                
                float viewHeight = self.bounds.size.height;
                float viewWidth = self.bounds.size.width;
                float x = (viewWidth-imageWidth)/2;
                float y = (viewHeight-imageHeight)/2;

                NSPoint q = [self convertPoint:[theEvent locationInWindow] fromView: nil];
                [opticalImage removePointAtX: (q.x-x)/scale andY: (viewHeight-q.y-y)/scale];
            }
                [document redraw: self];
            break;
            
            
        default:;
    }
}



-(void)drawCircle: (NSPoint)circle fromPoint: (NSPoint)p withScale: (float)scale withColor: (NSColor *)c andLabel: (NSString *)s
{
    float imageHeight = opticalImage.size_y;

	double radius = scale*[[opticalImage.data objectForKey: @"point.radius"] doubleValue];
    if(radius == 0)
        radius = scale*15;  //default radius is 15
	
	NSPoint center = NSMakePoint(p.x+scale*circle.x, p.y+scale*(imageHeight-circle.y));
	if(center.x != 0)
	{
		[c set];
		NSRect r = NSMakeRect(center.x-radius, center.y-radius, 2*radius, 2*radius);
		NSBezierPath * circle = [NSBezierPath bezierPathWithOvalInRect: r];    
		[circle stroke];
		
		NSRect tr = NSMakeRect(center.x-radius, center.y-8, 2*radius, 16);
		NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
		[style setAlignment:NSCenterTextAlignment];
		NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys: style,NSParagraphStyleAttributeName, c, NSForegroundColorAttributeName, nil];
		[s drawInRect: tr withAttributes: attr];
	}
}


/*
-(void)drawMaxPointAtPoint: (NSPoint)p atScale: (float)scale
{
    NSImage *image = opticalImage.signalImage;
    
    float imageHeight = image.size.height;
	float radius = scale*15;
	
	float peak_x = [[opticalImage.data objectForKey: @"signal.peak.x"] floatValue];
	float peak_y = [[opticalImage.data objectForKey: @"signal.peak.y"] floatValue];
	
	NSPoint center = NSMakePoint(p.x+scale*peak_x, p.y+scale*(imageHeight-peak_y));
	if(center.x != 0)
	{
		[[NSColor greenColor] set];
		NSRect r = NSMakeRect(center.x-radius, center.y-radius, 2*radius, 2*radius);
		NSBezierPath * circle = [NSBezierPath bezierPathWithOvalInRect: r];    
		[circle stroke];
		
		NSRect tr = NSMakeRect(center.x-radius, center.y-8, 2*radius, 16);
		NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
		[style setAlignment:NSCenterTextAlignment];
		NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys: style,NSParagraphStyleAttributeName, [NSColor greenColor],NSForegroundColorAttributeName, nil];
		[[NSString stringWithFormat: @"max"] drawInRect: tr withAttributes: attr];
	}
}
*/

// - (NSBitmapImageRep *)createPseudocolorImageForFrameFromFloatImage: (int)frame
/*
-(void)drawPseudocolorAtFrame: (int)frame atPoint: (NSPoint)p withThreshold: (double)threshold andOpacity: (float)t andScale: (float)scale
{
    NSImage *image = opticalImage.signalImage;
    
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;

    UInt16 * signal = (UInt16 *)[[[image representations] objectAtIndex:frame] bitmapData];
    
    double max = 0;
    for(int i=0; i<imageWidth*imageHeight; i++)
        if((double)signal[i] > max)
            max = (double)signal[i];

//	NSLog(@"MAX = %lf\n", max);

	// FIXME: Restore original max - FIXAT
	//
	//
	//
	//
	//
	//
	//
	//	max = 31646.0;
	
    NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc]
                                initWithBitmapDataPlanes:NULL
                                pixelsWide:imageWidth
                                pixelsHigh:imageHeight
                                bitsPerSample:8
                                samplesPerPixel:4
                                hasAlpha:YES     // change later
                                isPlanar:NO
                                colorSpaceName:NSCalibratedRGBColorSpace
                                bitmapFormat:0
                                bytesPerRow:4*imageWidth
                                bitsPerPixel:4*8];
    unsigned char *pix = [bitmap bitmapData];
    
    if(max == 0)
        for(int i=0; i<imageWidth*imageHeight; i++)
        {
            pix[4*i] = 0;
            pix[4*i+1] = 0;
            pix[4*i+2] = 0;
            pix[4*i+3] = 0;
        }
        
    else    
        for(int i=0; i<imageWidth*imageHeight; i++)
        {
            int v = (unsigned char)(255*((double)signal[i]/max));

            if(((double)signal[i]/max) >= threshold)
            {
                pix[4*i] = LUT_fire[v][0];
                pix[4*i+1] = LUT_fire[v][1];
                pix[4*i+2] = LUT_fire[v][2];
                pix[4*i+3] = 255;
            }
            else
            {
                pix[4*i] = 0;
                pix[4*i+1] = 0;
                pix[4*i+2] = 0;
                pix[4*i+3] = 0;
            }
        }

//    [bitmap drawInRect: NSMakeRect(p.x, p.y, imageWidth, imageHeight)];    
     [bitmap drawInRect: NSMakeRect(p.x, p.y, scale*imageWidth, scale*imageHeight)
            fromRect: NSMakeRect(0, 0, imageWidth, imageHeight)
            operation:NSCompositeSourceOver 
            fraction:t
            respectFlipped:NO 
            hints: nil
      ];   
    
//    [bitmap release];
}
*/



-(void)drawPseudocolorAverageAtPoint: (NSPoint)p withThreshold: (double)threshold andOpacity: (float)t andScale: (float)scale
{
    NSImage *image = opticalImage.averageImage;
    
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;

    UInt16 * signal = (UInt16 *)[[[image representations] objectAtIndex:0] bitmapData];
    
    double max = 0;
    for(int i=0; i<imageWidth*imageHeight; i++)
        if((double)signal[i] > max)
            max = (double)signal[i];

//	NSLog(@"MAX = %lf\n", max);

	// FIXME: Restore original max - FIXAT
	//
	//
	//
	//
	//
	//
	//
	//	max = 31646.0;
	
    NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc]
                                initWithBitmapDataPlanes:NULL
                                pixelsWide:imageWidth
                                pixelsHigh:imageHeight
                                bitsPerSample:8
                                samplesPerPixel:4
                                hasAlpha:YES     // change later
                                isPlanar:NO
                                colorSpaceName:NSCalibratedRGBColorSpace
                                bitmapFormat:0
                                bytesPerRow:4*imageWidth
                                bitsPerPixel:4*8];
    unsigned char *pix = [bitmap bitmapData];
    
    if(max == 0)
        for(int i=0; i<imageWidth*imageHeight; i++)
        {
            pix[4*i] = 0;
            pix[4*i+1] = 0;
            pix[4*i+2] = 0;
            pix[4*i+3] = 0;
        }
        
    else    
        for(int i=0; i<imageWidth*imageHeight; i++)
        {
            int v = (unsigned char)(255*((double)signal[i]/max));

            if(((double)signal[i]/max) >= threshold)
            {
                pix[4*i] = LUT_fire[v][0];
                pix[4*i+1] = LUT_fire[v][1];
                pix[4*i+2] = LUT_fire[v][2];
                pix[4*i+3] = 255;
            }
            else
            {
                pix[4*i] = 0;
                pix[4*i+1] = 0;
                pix[4*i+2] = 0;
                pix[4*i+3] = 0;
            }
        }

//    [bitmap drawInRect: NSMakeRect(p.x, p.y, imageWidth, imageHeight)];    
     [bitmap drawInRect: NSMakeRect(p.x, p.y, scale*imageWidth, scale*imageHeight)
            fromRect: NSMakeRect(0, 0, imageWidth, imageHeight)
            operation:NSCompositeSourceOver 
            fraction:t
            respectFlipped:NO 
            hints: nil
      ];   
    
//    [bitmap release];
}



/*
-(void)createPseudocolorImage
{
    int frame = [[opticalImage.data objectForKey: @"signal.peak"] intValue];
    double min = [[opticalImage.data objectForKey: @"pseudo.min"] doubleValue];
    double max = [[opticalImage.data objectForKey: @"pseudo.max"] doubleValue];
    double threshold = [[opticalImage.data objectForKey: @"pseudo.threshold"] doubleValue];
    
    NSImage *image = opticalImage.signalImage;
    NSImage *source = opticalImage.sourceTIFF;
    
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    
    UInt16 * signal = (UInt16 *)[[[image representations] objectAtIndex:frame] bitmapData];
    UInt16 * src    = (UInt16 *)[[[source representations] objectAtIndex:frame] bitmapData];
                                 
    if(max == 0)
    {
        for(int i=0; i<imageWidth*imageHeight; i++)
            if((double)signal[i] > max)
                max = (double)signal[i];
        max /= 100000.0;
    }

    NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc]
                                initWithBitmapDataPlanes:NULL
                                pixelsWide:imageWidth
                                pixelsHigh:imageHeight
                                bitsPerSample:8
                                samplesPerPixel:4
                                hasAlpha:YES     // change later
                                isPlanar:NO
                                colorSpaceName:NSCalibratedRGBColorSpace
                                bitmapFormat:0
                                bytesPerRow:4*imageWidth
                                bitsPerPixel:4*8];
    unsigned char *pix = [bitmap bitmapData];

    for(int i=0; i<imageWidth*imageHeight; i++)
    {
        double s = (double)(signal[i])/100000.0;
        int v = (unsigned char)255;
        if(s < max)
            v = (unsigned char)(255*((double)(s-min)/(max-min)));
        
        if(s >= threshold)
        {
            pix[4*i]   = LUT_fire[v][0];
            pix[4*i+1] = LUT_fire[v][1];
            pix[4*i+2] = LUT_fire[v][2];
            pix[4*i+3] = 255;
        }
        else
        {
            pix[4*i]   = src[i] >> 1;
            pix[4*i+1] = src[i] >> 1;
            pix[4*i+2] = src[i] >> 1;
            pix[4*i+3] = 255;
        }
    }

    [bitmap drawInRect: NSMakeRect(0, 0, imageWidth, imageHeight)];    
    
    NSData * tiffData = [bitmap TIFFRepresentation];
    
    NSURL * url = [[opticalImage.tiffURL URLByDeletingPathExtension] URLByAppendingPathExtension: @"processed.tiff"];
    [tiffData writeToURL: url atomically: YES];
    
    [bitmap release];
}
*/



- (void)drawSignalGraphAt: (NSPoint)p
{
/*
    int count = opticalImage.signalCurve.count;
    float step = 8.0;
    float graphHeight = 100.0;
	
    // Draw stimulus time
    
    [[NSColor colorWithCalibratedWhite: 0.9 alpha: 1.0] set];
    int stimulusStart = [[opticalImage.data objectForKey: @"stimulus.start"] intValue];
    int stimulusEnd = [[opticalImage.data objectForKey: @"stimulus.end"] intValue];
	
    NSRectFill(NSMakeRect(p.x+stimulusStart*step, p.y, step*(stimulusEnd-stimulusStart), graphHeight));
    
    // Draw Grid Lines
    
    [[NSColor gridColor] set];
    for(int i=0; i<count+1; i+=5)
    {
        NSBezierPath* axes = [NSBezierPath bezierPath];
        [axes moveToPoint: NSMakePoint(p.x+step*i, p.y)];
        [axes lineToPoint: NSMakePoint(p.x+step*i, p.y+graphHeight)];
        [axes stroke];
    }
	
	// Draw Current Frame Marker
	
    [[NSColor blackColor] set];
	NSBezierPath* frameMark = [NSBezierPath bezierPath];
	[frameMark moveToPoint: NSMakePoint(p.x+step*frameInView, p.y-1.5)];
	[frameMark lineToPoint: NSMakePoint(p.x+step*frameInView-4.5, p.y-4.5-1.5)];
	[frameMark lineToPoint: NSMakePoint(p.x+step*frameInView+4.5, p.y-4.5-1.5)];
	[frameMark lineToPoint: NSMakePoint(p.x+step*frameInView, p.y-1.5)];
	[frameMark fill];

	
    // Draw axes
    
    [[NSColor blackColor] set];
    NSFrameRect(NSMakeRect(p.x-0.5, p.y, step*count+1, graphHeight));
    
    // Find max
    
    double max = 0;
    for(int i=0; i<count; i++)
    {
        double v = [[opticalImage.signalCurve objectAtIndex: i] doubleValue];
        if(v > max)
            max = v;
    }
	
    NSPoint center = [opticalImage point: 0];
    if(center.x > 0)
    {
        for(int i=0; i<count; i++)
        {
            double v = [[opticalImage.signalCurveInPoint objectAtIndex: i] doubleValue];
            if(v > max)
                max = v;
        }
    }

    double max_val = 0;
    while(max_val < max)
        max_val += 0.01;
	
    // Draw signal
    
    NSBezierPath* aPath = [NSBezierPath bezierPath];
    if(max_val != 0)
        for(int i=0; i<count; i++)
        {
            double v = [[opticalImage.signalCurve objectAtIndex: i] doubleValue];
            
            float x = p.x+(float)i*step;
            float y = p.y + graphHeight*(v/max_val);
            
            NSPoint p = NSMakePoint(x, y);
            if(i==0)
                [aPath moveToPoint: p];
            else
                [aPath lineToPoint: p];
        }
    [aPath setLineJoinStyle:NSRoundLineJoinStyle];
    [aPath stroke];
	
    [@"0" drawInRect: NSMakeRect(p.x+step*count+10, p.y, 100, 20)  withAttributes:0];
    [[NSString stringWithFormat: @"%.2lf", max_val] drawInRect: NSMakeRect(p.x+step*count+10, p.y+graphHeight-24, 100, 20)  withAttributes:0];
	
    // Draw signal in point 1

    if(center.x > 0)
    {
        NSBezierPath* aPath = [NSBezierPath bezierPath];
        [[NSColor redColor] set];
        if(max_val != 0)
            for(int i=0; i<count; i++)
            {
                double v = [[opticalImage.signalCurveInPoint objectAtIndex: i] doubleValue];
                
                if(v <0) v = 0; // Clip
                
                float x = p.x+(float)i*step;
                float y = p.y + graphHeight*(v/max_val);
                
                NSPoint p = NSMakePoint(x, y);
                if(i==0)
                    [aPath moveToPoint: p];
                else
                    [aPath lineToPoint: p];
            }
        [aPath setLineJoinStyle:NSRoundLineJoinStyle];
        [aPath stroke];
	
        // [@"0" drawInRect: NSMakeRect(p.x+step*count+10, p.y, 100, 20)  withAttributes:0];
        // [[NSString stringWithFormat: @"%.2lf", max_val] drawInRect: NSMakeRect(p.x+step*count+10, p.y+graphHeight-24, 100, 20)  withAttributes:0];
        [[NSColor blackColor] set];
	}
    
    // Draw measurement range
    
    int measure_start = 0;
    int measure_end = count;
    
    if([opticalImage.data objectForKey: @"measure.start"] != nil)
        measure_start = [[opticalImage.data objectForKey: @"measure.start"] intValue];
    
    if([opticalImage.data objectForKey: @"measure.end"] != nil)
        measure_end = [[opticalImage.data objectForKey: @"measure.end"] intValue];
    
    if(measure_end > count-1)
        measure_end = count-1;
	
    NSBezierPath* tick1 = [NSBezierPath bezierPath];    
    [tick1 moveToPoint: NSMakePoint(p.x+measure_start*step, p.y-20.5)];
    [tick1 lineToPoint: NSMakePoint(p.x+measure_start*step, p.y-25.5)];
    [tick1 stroke];
	
    NSBezierPath* tick2 = [NSBezierPath bezierPath];    
    [tick2 moveToPoint: NSMakePoint(p.x+(measure_end-1)*step, p.y-20.5)];
    [tick2 lineToPoint: NSMakePoint(p.x+(measure_end-1)*step, p.y-25.5)];
    [tick2 stroke];
    
    NSBezierPath* rangePath = [NSBezierPath bezierPath];    
    [rangePath moveToPoint: NSMakePoint(p.x+measure_start*step, p.y-25.5)];
    [rangePath lineToPoint: NSMakePoint(p.x+(measure_end-1)*step, p.y-25.5)];
    [rangePath stroke];
    
    // TODO: draw magnitude as number below range
	
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSCenterTextAlignment];
    NSDictionary *attr = [NSDictionary dictionaryWithObject:style forKey:NSParagraphStyleAttributeName];
    double magnitude = [[opticalImage.data objectForKey: @"signal.magnitude"] doubleValue];
    [[NSString stringWithFormat: @"%.4lf", magnitude]
	 drawInRect: NSMakeRect(p.x+measure_start*step, p.y-50, (measure_end-measure_start)*step, 20) 
	 withAttributes: attr];
 //   [style release];
    
    // Draw onset, offset and peak
    
    int onset = [[opticalImage.data objectForKey: @"signal.onset"] intValue];
    int offset = [[opticalImage.data objectForKey: @"signal.offset"] intValue];
    int peak = [[opticalImage.data objectForKey: @"signal.peak"] intValue];
	
    const CGFloat pattern[2] = {(CGFloat)(step-4), 4.0};
    NSBezierPath* signalPath = [NSBezierPath bezierPath];    
    [signalPath moveToPoint: NSMakePoint(p.x+onset*step, p.y-10.5)];
    [signalPath lineToPoint: NSMakePoint(p.x+offset*step, p.y-10.5)];
    [signalPath setLineDash: pattern count: 2 phase: -2];
    [signalPath stroke];
	
    NSBezierPath* tickOnset = [NSBezierPath bezierPath];    
    [tickOnset moveToPoint: NSMakePoint(p.x+onset*step, p.y-5.5)];
    [tickOnset lineToPoint: NSMakePoint(p.x+onset*step, p.y-15.5)];
    [tickOnset stroke];
    
    NSBezierPath* tickOffset = [NSBezierPath bezierPath];    
    [tickOffset moveToPoint: NSMakePoint(p.x+offset*step, p.y-5.5)];
    [tickOffset lineToPoint: NSMakePoint(p.x+offset*step, p.y-15.5)];
    [tickOffset stroke];
    
    NSBezierPath* tickPeak = [NSBezierPath bezierPath];    
    [tickPeak moveToPoint: NSMakePoint(p.x+peak*step, p.y-5.5)];
    [tickPeak lineToPoint: NSMakePoint(p.x+peak*step, p.y-15.5)];
    [tickPeak stroke];
*/
}



- (void)drawMotionGraphAt: (NSPoint)p
{
/*
    int count = opticalImage.motionCurve.count;
    float step = 8.0;
    float graphHeight = 100.0;
	
    // Draw stimulus time
    
    [[NSColor colorWithCalibratedWhite: 0.9 alpha: 1.0] set];
    int stimulusStart = [[opticalImage.data objectForKey: @"stimulus.start"] intValue];
    int stimulusEnd = [[opticalImage.data objectForKey: @"stimulus.end"] intValue];
	
    NSRectFill(NSMakeRect(p.x+stimulusStart*step, p.y, step*(stimulusEnd-stimulusStart), graphHeight));
    
    // Draw Grid Lines
    
    [[NSColor gridColor] set];
    for(int i=0; i<count+1; i+=5)
    {
        NSBezierPath* axes = [NSBezierPath bezierPath];
        [axes moveToPoint: NSMakePoint(p.x+step*i, p.y)];
        [axes lineToPoint: NSMakePoint(p.x+step*i, p.y+graphHeight)];
        [axes stroke];
    }
	
    // Draw axes
    
    [[NSColor blackColor] set];
    NSFrameRect(NSMakeRect(p.x-0.5, p.y, step*count+1, graphHeight));
    
    // Find max
    
    double max = 0;
    for(int i=0; i<count; i++)
    {
		double v = [[opticalImage.motionCurve objectAtIndex: i] doubleValue];
        if(v > max)
            max = v;
    }
	
    double max_val = 0;
    while(max_val < max)
        max_val += 1;
	
    // Draw signal
    
    NSBezierPath* aPath = [NSBezierPath bezierPath];    
    if(max_val != 0)
        for(int i=0; i<count; i++)
        {
            double v = [[opticalImage.motionCurve objectAtIndex: i] doubleValue];
            
            float x = p.x+(float)i*step;
            float y = p.y + graphHeight*(v/max_val);
            
            NSPoint p = NSMakePoint(x, y);
            if(i==0)
                [aPath moveToPoint: p];
            else
                [aPath lineToPoint: p];
        }
    [aPath setLineJoinStyle:NSRoundLineJoinStyle];
    [aPath stroke];
	
    [@"0" drawInRect: NSMakeRect(p.x+step*count+10, p.y, 100, 20)  withAttributes:0];
    [[NSString stringWithFormat: @"%.2lf", max_val] drawInRect: NSMakeRect(p.x+step*count+10, p.y+graphHeight-24, 100, 20)  withAttributes:0];
*/
}



- (void)drawOverview
{
    return;
/*
    
    const CGFloat pattern[2] = {3.0, 2.0};
    
//  float viewWidth = self.bounds.size.width;
    float viewHeight = self.bounds.size.height;
    float graphHeight = 200.0;
    float marginTop = 10.5;
    float marginLeft = 10.5;
    float step = 8.0;
    int count = opticalImage.sourceTIFF.representations.count;

//    double min = [[opticalImage.data objectForKey: @"image.avg.min"] doubleValue];
//    double max = [[opticalImage.data objectForKey: @"image.avg.max"] doubleValue];

    double min = [[opticalImage.data objectForKey: @"image.curve.min"] doubleValue];
    double max = [[opticalImage.data objectForKey: @"image.curve.max"] doubleValue];
    int stimulusStart = [[opticalImage.data objectForKey: @"stimulus.start"] intValue];
    int stimulusEnd = [[opticalImage.data objectForKey: @"stimulus.end"] intValue];
    
    [[NSString stringWithFormat: @"%.0lf", min] drawInRect: NSMakeRect(marginLeft+step*count+10, viewHeight-marginTop-graphHeight, 100, 20)  withAttributes:0];
    [[NSString stringWithFormat: @"%.0lf", max] drawInRect: NSMakeRect(marginLeft+step*count+10, viewHeight-marginTop-24, 100, 20)  withAttributes:0];

    // Draw stimulus time
    
    [[NSColor colorWithCalibratedWhite: 0.9 alpha: 1.0] set];

    NSRectFill(NSMakeRect(marginLeft-0.5+stimulusStart*step, viewHeight-marginTop+0.5-graphHeight, step*(stimulusEnd-stimulusStart), graphHeight));
    
    // Draw Grid Lines
    
    [[NSColor gridColor] set];
    for(int i=0; i<count+1; i+=5)
    {
        NSBezierPath* axes = [NSBezierPath bezierPath];
        [axes moveToPoint: NSMakePoint(marginLeft+step*i, viewHeight-marginTop)];
        [axes lineToPoint: NSMakePoint(marginLeft+step*i, viewHeight-marginTop-graphHeight)];
        [axes stroke];
    }
    
    // Draw axes
    
    [[NSColor blackColor] set];
    NSFrameRect(NSMakeRect(marginLeft-0.5, viewHeight-marginTop+0.5-graphHeight, step*count+1, graphHeight));

    // Draw Tick Marks
    
    for(int i=0; i<count+1; i++)
    {
        NSBezierPath* axes = [NSBezierPath bezierPath];
        [axes moveToPoint: NSMakePoint(marginLeft+step*i, viewHeight-marginTop-graphHeight)];
        [axes lineToPoint: NSMakePoint(marginLeft+step*i, viewHeight-marginTop-graphHeight-10)];
        [axes setLineCapStyle: NSSquareLineCapStyle];
        [axes stroke];
    }

    // Draw decay curve for full image
    
    NSBezierPath* aPath = [NSBezierPath bezierPath];    
    if(max != min)
        for(int i=0; i<count; i++)
        {
            double v = [[opticalImage.decayCurve objectAtIndex: i] doubleValue];
            float x = marginLeft+(float)i*step;
            float y = viewHeight-marginTop-graphHeight + graphHeight*(v-min)/(max-min);
            
            NSPoint p = NSMakePoint(x, y);
            if(i==0)
                [aPath moveToPoint: p];
            else
                [aPath lineToPoint: p];
        }
    [aPath setLineJoinStyle:NSRoundLineJoinStyle];
    [aPath stroke];
    
    // Draw linear regression line
    
    NSBezierPath* aRegPath = [NSBezierPath bezierPath];    
    if(max != min)
        for(int i=0; i<count; i++)
        {
            double v = [[opticalImage.regressionCurve objectAtIndex: i] doubleValue];
            float x = marginLeft+(float)i*step;
            float y = viewHeight-marginTop-graphHeight + graphHeight*(v-min)/(max-min);
            
            NSPoint p = NSMakePoint(x, y);
            if(i==0)
                [aRegPath moveToPoint: p];
            else
                [aRegPath lineToPoint: p];
        }
    
    [aRegPath setLineJoinStyle:NSRoundLineJoinStyle];
    [aRegPath setLineDash: pattern count: 2 phase: 0];
    [aRegPath stroke];
    
    [self drawSignalGraphAt: NSMakePoint(marginLeft, viewHeight-350)];
//    [self drawMotionGraphAt: NSMakePoint(marginLeft, viewHeight-500)];

    // Draw images
    
    float overviewScale = 320.0/opticalImage.scaledImage.size.width;
    
//    int peak = [[opticalImage.data objectForKey: @"signal.peak"] intValue];
    int imageHeight = overviewScale * [[opticalImage.data objectForKey: @"image.height"] intValue];
    float drawThreshold = [[opticalImage.data objectForKey: @"draw.threshold"] floatValue];
    if(drawThreshold == 0)
        drawThreshold = 0.6;

	NSPoint p = NSMakePoint(step*count+70, viewHeight-imageHeight-10);
    [self drawOriginalAtFrame: frameInView atPoint: p withScale: overviewScale];
//    [self drawPseudocolorAtFrame: frameInView atPoint: p withThreshold: 0.3 andOpacity: 1.0 andScale: overviewScale];
    [self drawPseudocolorAtFrame: frameInView atPoint: p withThreshold: drawThreshold andOpacity: 0.75 andScale: overviewScale];     // FIXME: Ändrat för ANNA

//    [self drawOriginalAtFrame: frameInView atPoint: NSMakePoint(step*count+70, viewHeight-imageHeight-10) withScale: 1.0];
//    [self drawPseudocolorAtFrame: frameInView atPoint: NSMakePoint(step*count+70, viewHeight-imageHeight-10) withThreshold: 0.6 andOpacity: 0.5 andScale: 1.0];

    p = NSMakePoint(step*count+70, viewHeight-2*imageHeight-30);
	[self drawPseudocolorAtFrame: frameInView atPoint: p withThreshold: 0 andOpacity: 1.0 andScale: overviewScale];
	
    
    p = NSMakePoint(step*count+70, viewHeight-3*imageHeight-50);
 	[self drawPseudocolorAverageAtPoint: p withThreshold: 0 andOpacity: 1.0 andScale: overviewScale];
   
 */
    
/*
	float peak_x = [[opticalImage.data objectForKey: @"signal.peak.x"] floatValue];
	float peak_y = [[opticalImage.data objectForKey: @"signal.peak.y"] floatValue];
    [self drawCircle: NSMakePoint(peak_x, peak_y) fromPoint: p withScale: overviewScale withColor: [NSColor greenColor] andLabel: @"max"]; 
*/
	// Draw point activity
/*
	bool drawPointActivity = false;
    for(int i=0; i<8; i++)
	{
		NSPoint center = [opticalImage point: i];
		if(center.x != 0)
			drawPointActivity = true;
	}
	
	if(drawPointActivity)
	{
		NSPoint pp = NSMakePoint(marginLeft-0.5, viewHeight-2*imageHeight-30-120);
		[[NSColor blackColor] set];
		NSFrameRect(NSMakeRect(pp.x, pp.y, 10*20+4, 100));

		// find max
		
		float max = 0;
		for(int i=0; i<10; i++)
		{
			float v = [[opticalImage.data objectForKey: [NSString stringWithFormat: @"p%d.magnitude", i+1]] floatValue];
			if(v > max)
				 max = v;
		}
				
		float top = 0.025;
		while(max > top)
			top *= 2.0;
			
		[[NSString stringWithFormat: @"%.2lf", top] drawInRect: NSMakeRect(pp.x+10*20+4+4, pp.y+100-20, 100, 20) withAttributes:0];

		for(int i=0; i<10; i++)
		{
			float v = [[opticalImage.data objectForKey: [NSString stringWithFormat: @"p%d.magnitude", i+1]] floatValue];
			NSFrameRect(NSMakeRect(3+pp.x+20*i,pp.y,18, 100*v/top));
		}
	}
*/
    // TEST: Get metadata from TIFF image

/*    
    NSData * data = [[opticalImage.sourceTIFF.representations objectAtIndex: 0] TIFFRepresentation];
    CGImageSourceRef source = CGImageSourceCreateWithData( (CFDataRef) data, NULL);
    CGImageSourceRef source = CGImageSourceCreateWithURL( (CFURLRef) aUrl, NULL);
    NSDictionary* metadata = (NSDictionary *)CGImageSourceCopyPropertiesAtIndex(source, 0, NULL);
    NSLog(@"TIFF Metadata: %@", metadata);
*/
}



- (void)drawOriginal
{
/*    [[NSColor darkGrayColor] set];
    NSRectFill(self.frame);
    
    NSImage *image = opticalImage.scaledImage;
    
    float scale = pow(2, viewScale);
    
    float imageHeight = scale*image.size.height;
    float imageWidth = scale*image.size.width;
    
    float viewHeight = self.bounds.size.height;
    float viewWidth = self.bounds.size.width;
    float x = (viewWidth-imageWidth)/2;
    float y = (viewHeight-imageHeight)/2;
    
    NSShadow * shadow = [NSShadow new];
    [shadow setShadowColor: [NSColor blackColor]];
    [shadow setShadowBlurRadius: 10.0f];
    [shadow setShadowOffset: NSMakeSize(5, -5)];
    [shadow set];

    [(NSBitmapImageRep *)[image.representations objectAtIndex: frameInView] drawInRect: NSMakeRect(x, y, imageWidth, imageHeight)];
    
    // Draw max
	
    NSPoint p = NSMakePoint(x,y);
	
	float peak_x = [[opticalImage.data objectForKey: @"signal.peak.x"] floatValue];
	float peak_y = [[opticalImage.data objectForKey: @"signal.peak.y"] floatValue];
    [self drawCircle: NSMakePoint(peak_x, peak_y) fromPoint: p withScale: scale withColor: [NSColor greenColor] andLabel: @"max"]; 
	
	// draw points
	
    [shadow setShadowColor: [NSColor blackColor]];
    [shadow setShadowBlurRadius: 0.0f];
    [shadow setShadowOffset: NSMakeSize(0, 0)];
    [shadow set];
    
    for(int i=0; i<8; i++)
	{
		NSPoint center = [opticalImage point: i];
		if(center.x != 0)
			[self drawCircle: center fromPoint: p withScale: scale withColor: [NSColor redColor] andLabel: [NSString stringWithFormat: @"%d", i+1]]; 
	}
*/
}

 

- (void)drawOriginalSequence
{
/*
    [[NSColor darkGrayColor] set];
    NSRectFill(self.frame);

    NSImage *image = opticalImage.scaledImage;
    
    float scale = 128.0/image.size.width;
    float imageWidth = scale*image.size.width;
    float imageHeight = scale*image.size.height;
    float viewWidth = self.bounds.size.width;
    float viewHeight = self.bounds.size.height;
    
    NSShadow * shadow = [NSShadow new];
    [shadow setShadowColor: [NSColor blackColor]];
    [shadow setShadowBlurRadius: 7.0f];
    [shadow setShadowOffset: NSMakeSize(3, -3)];
    [shadow set];
    
    float margin = 15.0;
    float x = 0;
    float y = 0;
    for(int i=0; i<image.representations.count; i++)
    {
        [(NSBitmapImageRep *)[image.representations objectAtIndex: i] drawInRect: NSMakeRect(margin+x,-margin+y+viewHeight-imageHeight, imageWidth, imageHeight)];
        x += imageWidth+margin;
        if(x > viewWidth - imageWidth)
        {
            x = 0;
            y -= imageHeight+margin;
        }
    }
*/
}



- (void)drawMotionRemoved
{
/*
    NSImage *image = opticalImage.motionRemovedImage;
    
    float scale = pow(2, viewScale);
    float imageWidth = scale*image.size.width;
    float imageHeight = scale*image.size.height;
    //    float viewWidth = self.bounds.size.width;
    float viewHeight = self.bounds.size.height;
    
    float margin = 5.0;
    float x = 0;
    float y = 0;
    
    [(NSBitmapImageRep *)[image.representations objectAtIndex: frameInView] drawInRect: NSMakeRect(margin+x,-margin+y+viewHeight-imageHeight, imageWidth, imageHeight)];
*/
}



- (void)drawMotionRemovedSequence
{
/*
    NSImage *image = opticalImage.motionRemovedImage;
    
    float scale = 128.0/image.size.width;
    float imageWidth = scale*image.size.width;
    float imageHeight = scale*image.size.height;
    float viewWidth = self.bounds.size.width;
    float viewHeight = self.bounds.size.height;
    
    float margin = 5.0;
    float x = 0;
    float y = 0;
    for(int i=0; i<image.representations.count; i++)
    {
        [(NSBitmapImageRep *)[image.representations objectAtIndex: i] drawInRect: NSMakeRect(margin+x,-margin+y+viewHeight-imageHeight, imageWidth, imageHeight)];
        x += imageWidth+margin;
        if(x > viewWidth - imageWidth)
        {
            x = 0;
            y -= imageHeight+margin;
        }
    }
*/
}



typedef struct
{
    unsigned char red;
    unsigned char green;
    unsigned char blue;
    unsigned char alpha;
} RGBPixel;



- (void)drawMask
{
/*    [[NSColor darkGrayColor] set];
    NSRectFill(self.frame);
    
    float scale = pow(2, viewScale);
    
    float imageHeight = scale*opticalImage.size_y;
    float imageWidth = scale*opticalImage.size_x;
    
    float viewHeight = self.bounds.size.height;
    float viewWidth = self.bounds.size.width;
    float x = (viewWidth-imageWidth)/2;
    float y = (viewHeight-imageHeight)/2;
    
    NSShadow * shadow = [NSShadow new];
    [shadow setShadowColor: [NSColor blackColor]];
    [shadow setShadowBlurRadius: 10.0f];
    [shadow setShadowOffset: NSMakeSize(5, -5)];
    [shadow set];
    
    // Draw "source" image
    
//    [(NSBitmapImageRep *)[opticalImage.motionRemovedImage.representations objectAtIndex: frameInView] drawInRect: NSMakeRect(x, y, imageWidth, imageHeight)];

    // Create red overlay red mask image
    
    NSBitmapImageRep * maskImageRep = [[opticalImage.maskImage.representations objectAtIndex: 0] copy];
    UInt16 * maskPixels = (UInt16 *)[maskImageRep bitmapData];

    NSSize imageSize = {image.size.width, image.size.height};
    
    NSBitmapImageRep * bitmapImageRep =
        [[NSBitmapImageRep alloc]
            initWithBitmapDataPlanes:(unsigned char **)NULL
            pixelsWide:(int)imageSize.width
            pixelsHigh:(int)imageSize.height
            bitsPerSample:(int)8
            samplesPerPixel:(int)4
            hasAlpha:(BOOL)YES
            isPlanar:(BOOL)NO
            colorSpaceName:(NSString *)NSDeviceRGBColorSpace
            bytesPerRow:(int)(imageSize.width * sizeof(RGBPixel))
            bitsPerPixel:(int)0
        ];
    
    
    RGBPixel * pixels = (RGBPixel *)[bitmapImageRep bitmapData];
    
    // Draw a red diagonal line
    
    for (NSUInteger row = 0; row < imageSize.height; row++)
        for (NSUInteger col = 0; col < imageSize.width; col++)
            if (maskPixels[row * (int)imageSize.width + col] != 0)
            {
                pixels[row * (int)imageSize.width + col].red = 64;
                pixels[row * (int)imageSize.width + col].alpha = 64;
            }
    
    [bitmapImageRep drawInRect: NSMakeRect(x, y, imageWidth, imageHeight)
        fromRect: NSZeroRect
        operation: NSCompositeSourceAtop //NSCompositeCopy // NSCompositeSourceAtop
        fraction: 1.0
        respectFlipped:NO
        hints: nil
     ];

//    [@"Mask" drawAtPoint: NSMakePoint(20, 20)  withAttributes:0];
    
//    [maskImageRep release];
//    [bitmapImageRep release];
*/
}



- (void)drawProcessed
{
    [[NSColor darkGrayColor] set];
    NSRectFill(self.frame);

    float scale = pow(2, viewScale);
    
    float imageHeight = scale*opticalImage.size_y;
    float imageWidth = scale*opticalImage.size_x;

    float viewHeight = self.bounds.size.height;
    float viewWidth = self.bounds.size.width;
    float x = (viewWidth-imageWidth)/2;
    float y = (viewHeight-imageHeight)/2;
    
    NSShadow * shadow = [NSShadow new];
    [shadow setShadowColor: [NSColor blackColor]];
    [shadow setShadowBlurRadius: 10.0f];
    [shadow setShadowOffset: NSMakeSize(5, -5)];
    [shadow set];
    
    NSBitmapImageRep *bitmap = [opticalImage createPseudocolorImage: frameInView];
    [bitmap drawInRect: NSMakeRect(x, y, imageWidth, imageHeight)];  


    NSBitmapImageRep *mask = [opticalImage createMaskImage];
    [mask drawInRect: NSMakeRect(x, y, imageWidth, imageHeight)
        fromRect: NSZeroRect
        operation: NSCompositeSourceAtop //NSCompositeCopy // NSCompositeSourceAtop
        fraction: 1.0
        respectFlipped:NO
        hints: nil
     ];


    // Draw max

    NSPoint p = NSMakePoint(x,y);
/*		
	float peak_x = [[opticalImage.data objectForKey: @"signal.peak.x"] floatValue];
	float peak_y = [[opticalImage.data objectForKey: @"signal.peak.y"] floatValue];
    [self drawCircle: NSMakePoint(peak_x, peak_y) fromPoint: p withScale: scale withColor: [NSColor greenColor] andLabel: @"max"]; 
*/	
	// draw points
	
    [shadow setShadowColor: [NSColor blackColor]];
    [shadow setShadowBlurRadius: 0.0f];
    [shadow setShadowOffset: NSMakeSize(0, 0)];
    [shadow set];

    for(int i=1; i<=10; i++)
	{
		NSPoint center = [opticalImage point: i];
		if(center.x != 0)
			[self drawCircle: center fromPoint: p withScale: scale withColor: [NSColor redColor] andLabel: [NSString stringWithFormat: @"%d", i]]; 
	}
}



- (void)drawProcessedSequence
{
    [[NSColor darkGrayColor] set];
    NSRectFill(self.frame);
    
    float scale = 128.0/opticalImage.size_x;
    float imageHeight = scale*opticalImage.size_y;
    float imageWidth = scale*opticalImage.size_x;
    float viewWidth = self.bounds.size.width;
    float viewHeight = self.bounds.size.height;
    
    NSShadow * shadow = [NSShadow new];
    [shadow setShadowColor: [NSColor blackColor]];
    [shadow setShadowBlurRadius: 7.0f];
    [shadow setShadowOffset: NSMakeSize(3, -3)];
    [shadow set];
    
    float margin = 15.0;
    float x = 0;
    float y = 0;
    for(int i=0; i<opticalImage.count; i++)
    {
        NSBitmapImageRep *bitmap = [opticalImage createPseudocolorImage: i];
        [bitmap drawInRect: NSMakeRect(margin+x,-margin+y+viewHeight-imageHeight, imageWidth, imageHeight)];  
//        [bitmap release];

//        [(NSBitmapImageRep *)[image.representations objectAtIndex: i] drawInRect: NSMakeRect(margin+x,-margin+y+viewHeight-imageHeight, imageWidth, imageHeight)];
        x += imageWidth+margin;
        if(x > viewWidth - imageWidth)
        {
            x = 0;
            y -= imageHeight+margin;
        }
    }

//  [@"Processed Sequence" drawAtPoint: NSMakePoint(20, 20)  withAttributes:0];
}



- (void)drawRect:(NSRect)dirtyRect
{
    NSEraseRect(dirtyRect);
    
//    [self createPseudocolorImage];
    
    int viewType = [document.viewSelector selectedSegment];
    
    switch(viewType)
    {
/*
        case 0: [self drawOverview]; return;
        case 1: [self drawOriginal]; return;
        case 2: [self drawOriginalSequence]; return;
        case 3: [self drawMotionRemoved]; return;
        case 4: [self drawMotionRemovedSequence]; return;
        case 5: [self drawMask]; return;
*/
        case 0: [self drawProcessed]; return;
        case 1: [self drawProcessedSequence]; return;
    }
}



-(IBAction)changeFrame:(id)sender
{
	[self setNeedsDisplay: YES];
}



@end
