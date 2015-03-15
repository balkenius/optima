//
//  OpticalImage.M
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

#import "OpticalImage.h"
#include "IKAROS_Utils.h"
#include "IKAROS_Math.h"

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



@implementation OpticalImage

@synthesize tiffURL;
@synthesize dictionaryURL;
@synthesize pointsURL;

@synthesize sourceTIFF;
@synthesize averageImage;

@synthesize data;
@synthesize activityHistogram, activityHistogramMax;

@synthesize size_x;
@synthesize size_y;
@synthesize count;

@synthesize image_curve;
@synthesize regression_curve;
@synthesize signal_curve;

@synthesize image_curve_in_point;
@synthesize regression_curve_in_point;
@synthesize signal_curve_in_point;



- (void)calculateImageMinMaxAndCurve
{
    float mn, mx;
    float mm[2*count];

    int j=0;
    for(int i=0; i<count; i++)
    {
        ikaros::minmax(mm[j], mm[j+1], image[i], size_x, size_y);
        image_curve[i] = ikaros::mean(image[i], size_x, size_y);
        j+=2;
    }
    
    ikaros::minmax(mn, mx, mm, 2*count);
    
	[data setObject: [NSString stringWithFormat: @"%lf", (double)mn] forKey: @"image.min"];
	[data setObject: [NSString stringWithFormat: @"%lf", (double)mx] forKey: @"image.max"];

    ikaros::minmax(mn, mx, image_curve, count);
    
	[data setObject: [NSString stringWithFormat: @"%lf", (double)mn] forKey: @"image.curve.min"];
	[data setObject: [NSString stringWithFormat: @"%lf", (double)mx] forKey: @"image.curve.max"];
}



- (void)calculateSignalMinMaxAndCurve
{
    float mn, mx;
    float mm[2*count];

    int j=0;
    for(int i=0; i<count; i++)
    {
        ikaros::minmax(mm[j], mm[j+1], signal_image[i], size_x, size_y);
        signal_curve[i] = ikaros::mean(signal_image[i], size_x, size_y);
        j+=2;
    }
    
    ikaros::minmax(mn, mx, mm, 2*count);
    
	[data setObject: [NSString stringWithFormat: @"%lf", (double)mn] forKey: [prefix stringByAppendingString: @"signal.min"]];
	[data setObject: [NSString stringWithFormat: @"%lf", (double)mx] forKey: [prefix stringByAppendingString: @"signal.max"]];
    
    ikaros::minmax(mn, mx, signal_curve, count);
    
	[data setObject: [NSString stringWithFormat: @"%lf", (double)mn] forKey: [prefix stringByAppendingString: @"signal.curve.min"]];
	[data setObject: [NSString stringWithFormat: @"%lf", (double)mx] forKey: [prefix stringByAppendingString: @"signal.curve.max"]];
}



- (void)calculatePseudoLevels
{
    double mn = [[data objectForKey: [prefix stringByAppendingString: @"signal.min"]] doubleValue];
    double mx = [[data objectForKey: [prefix stringByAppendingString: @"signal.max"]] doubleValue];
    
    double pmin = mn + 0.25 * (mx - mn);
    double pmax = mn + 0.75 * (mx - mn);
    double pt   = mn + 0.33 * (mx - mn);
    
	[data setObject: [NSString stringWithFormat: @"%lf", pmin] forKey: @"pseudo.min"];
	[data setObject: [NSString stringWithFormat: @"%lf", pmax] forKey: @"pseudo.max"];
	[data setObject: [NSString stringWithFormat: @"%lf", pt] forKey: @"pseudo.threshold"];
}



-(void)calculateActivityHistogram
{
    double mn = [[data objectForKey: [prefix stringByAppendingString: @"signal.min"]] doubleValue];
    double mx = [[data objectForKey: [prefix stringByAppendingString: @"signal.max"]] doubleValue];

    for(int i=0; i<256; i++)
        activityHistogram[i] = 0;
    
    for(int k=0; k<count; k++)
       for(int j=0; j<size_y; j++)
        for(int i=0; i<size_x; i++)
        {
            int v = (unsigned char)(255*((signal_image[k][j][i]-mn)/(mx-mn)));
            if(0 < v && v < 256) // ignore black
                activityHistogram[v]+= 1;
        }
    
    for(int i=0; i<256; i++)
        activityHistogram[i] /= (double)(count*size_x*size_y);

    activityHistogramMax = 0;
    for(int i=0; i<256; i++)
        if(activityHistogram[i] > activityHistogramMax)
            activityHistogramMax = activityHistogram[i];
}



- (void)smoothImages
{
    int radius = [[data objectForKey: @"filter.radius"] doubleValue];

    if(radius == 0)
    {
        for(int k=0; k<count; k++)
            copy_matrix(smooth_image[k], image[k], size_x, size_y);
        return;
    }
    
    double L = 0.1;
    double sigma = sqrt(-(radius*radius) / (2*log(L)));
    int kwidth = (2*radius+1); 
    
    float ** kernel_f = create_matrix(kwidth, kwidth);
    for(int dx=-radius; dx<=radius; dx++)
        for(int dy=-radius; dy<=radius; dy++)
            kernel_f[dy+radius][dx+radius] = exp(-(dx*dx+dy*dy)/(2*sigma*sigma));

    ikaros::multiply(kernel_f, 1/ikaros::add(kernel_f, kwidth, kwidth), kwidth, kwidth);
    
    for(int k=0; k<count; k++)
        ikaros::conv2_same(smooth_image[k], image[k], kernel_f, size_x, size_y, kwidth, kwidth);
    
    free(kernel_f);
}



- (void)calculateMask
{
    float t = [[data objectForKey: @"mask.fraction"] floatValue];
    
    float min, max;
    ikaros::minmax(min, max, smooth_image[0], size_x, size_y);
    
    float threshold = t*max;
    
    for(int j=0; j<size_y; j++)
        for(int i=0; i<size_x; i++)
            if(smooth_image[0][j][i] > threshold)
                mask_image[j][i] = 0;
            else
                mask_image[j][i] = 1;
}



- (void)calculateSignalMeasurements;
{
    int measure_start = 0;
    int measure_end = count-1;
    
    if([data objectForKey: @"measure.start"] != nil)
        measure_start = [[data objectForKey: @"measure.start"] intValue];
    
    if([data objectForKey: @"measure.end"] != nil)
        measure_end = [[data objectForKey: @"measure.end"] intValue];
    
    if(measure_end > count-1)
        measure_end = count-1;
 
    // Max
    
    int peak = 0;
    double max = 0;
    for(int i=measure_start; i<measure_end; i++)
    {
        double v = signal_curve[i];
        if(v > max)
        {
            max = v;
            peak = i;
        }
    }

    [data setObject: [NSString stringWithFormat: @"%d", peak] forKey: [prefix stringByAppendingString: @"signal.peak"]];

    // Onset
    
    int onset = 0;
    for(int i=measure_start; i<measure_end; i++)
    {
        double v = signal_curve[i];
        if(v > 0)
        {
            onset = i;
            float s = (i==measure_start ? 0 : signal_curve[i-1]);
            [data setObject: [NSString stringWithFormat: @"%d", i] forKey: [prefix stringByAppendingString: @"signal.onset"]];
            float latency = signal_curve[i]!=s ? (i-1)-s/(signal_curve[i]-s) : float(i);
            [data setObject: [NSString stringWithFormat: @"%f", latency] forKey: [prefix stringByAppendingString: @"signal.latency"]];
            break;
        }
    }

    // Offset
    
    int offset = 0;
    for(int i=measure_end; i>measure_start; i--)
    {
        double v = signal_curve[i];
        if(v > 0)
        {
            offset = i;
            [data setObject: [NSString stringWithFormat: @"%d", i] forKey: [prefix stringByAppendingString: @"signal.offset"]];
            break;
        }
    }
    
    [data setObject: [NSString stringWithFormat: @"%d", offset-onset] forKey: [prefix stringByAppendingString: @"signal.duration"]];
    
    // Magnitude
    
    double sum = 0;
    for(int i=measure_start; i<measure_end; i++)
        sum += (signal_curve[i] > 0 ? signal_curve[i] : 0); // clip at zero

    double mean = 0;
    if(measure_start!=measure_end)
        mean = (measure_end-measure_start > 0 ? sum/(float)(measure_end-measure_start) : 0);
    
    [data setObject: [NSString stringWithFormat: @"%.4lf", sum] forKey: [prefix stringByAppendingString: @"signal.magnitude"]];
    [data setObject: [NSString stringWithFormat: @"%.4lf", mean] forKey: [prefix stringByAppendingString: @"signal.average"]];
    
    // Raw data
  
    NSString * s = @"";
    for(int i=0; i<count; i++)
        s = [s stringByAppendingFormat: @"%.6lf%@", signal_curve[i], (i!=count-1? @",\t" : @"")];

    [data setObject: s forKey: [prefix stringByAppendingString: @"signal.data"]];
}



- (void)calculatePixelBandPassReg
{
    int a = [[data objectForKey: @"bp.a"] intValue]; // a - bg width

    if(a == 0)
    {
        for(int f=0; f<count; f++)
            copy_matrix(regression_image[f], smooth_image[f], size_x, size_y);
    
        return;
    }
    
    for(int f=0; f<count; f++)
    {
        int low = f-a;
        int high = f+a;

        if(low < 0)
            low = 0;
        
        if(high > count)
            high = count;
        
        if(high==low)
            return;
        
        for(int j=0; j<size_y; j++)
            for(int i=0; i<size_x; i++)
            {
                double s = 0;
                for(int f=low; f<high; f++)
                    s += (double)smooth_image[f][j][i];
                    
                regression_image[f][j][i] = s / (double)(high-low);
            }
     }
    
    for(int f=0; f<count; f++)
    {
        regression_curve[f] = ikaros::mean(regression_image[f], size_x, size_y);
        if(isnan(regression_curve[f]))
            return;
    }
}



- (void)calculatePixelConstReg
{
    int a = [[data objectForKey: @"const.a"] intValue];
    int b = [[data objectForKey: @"const.b"] intValue];

    if(b <= a)
        return; // error
    
    float ** _alpha = create_matrix(size_x, size_y);

    for(int j=0; j<size_y; j++)
        for(int i=0; i<size_x; i++)
        {
            // Calculate regression parameters for each pixel

            double s = 0;
            for(int f=a; f<=b; f++)
                s += (double)smooth_image[f][j][i];
            
            _alpha[j][i] = s / (double)(b-a+1);
        }
        
    for(int f=0; f<count; f++)
        copy_matrix(regression_image[f], _alpha, size_x, size_y);
    
    for(int f=0; f<count; f++)
        regression_curve[f] = ikaros::mean(_alpha, size_x, size_y);
    
    destroy_matrix(_alpha);
}



- (void)calculatePixelLinReg
{
    int a = [[data objectForKey: @"lin.a"] intValue];
    int b = [[data objectForKey: @"lin.b"] intValue];
    int c = [[data objectForKey: @"lin.c"] intValue];
    int d = [[data objectForKey: @"lin.d"] intValue];

    if(c>count)
        c = count;
    if(d > count)
        d = count;
    
    // TODO: use vectorized versions

    float ** _alpha = create_matrix(size_x, size_y);
    float ** _beta  = create_matrix(size_x, size_y);

    for(int j=0; j<size_y; j++)
        for(int i=0; i<size_x; i++)
        {
            // Calculate regression parameters for each pixel

            for(int f=0; f<count; f++)
            {
                double mx = 0;
                double my = 0;
                
                for(int f=a; f<b; f++)
                {
                    mx += (double)(f);
                    my += (double)smooth_image[f][j][i];
                }
                
                for(int f=c; f<d; f++)
                {
                    mx += (double)(f);
                    my += (double)smooth_image[f][j][i];
                }
                
                mx /= (double)(b-a+d-c);
                my /= (double)(b-a+d-c);
                
                // calculate dx and dy products
                
                double Sxx = 0;
                double Sxy = 0;
                
                for(int f=a; f<b; f++)
                {
                    Sxx += ((double)(f) - mx) * ((double)(f) - mx);
                    Sxy += ((double)(f) - mx) * (smooth_image[f][j][i] - my);
                }
                
                for(int f=c; f<d; f++)
                {
                    Sxx += ((double)(f) - mx) * ((double)(f) - mx);
                    Sxy += ((double)(f) - mx) * (smooth_image[f][j][i] - my);
                }
                
                _beta[j][i]  = Sxy/Sxx;
                _alpha[j][i] = my - (Sxy/Sxx)*mx;
            }
        }
        

    for(int f=0; f<count; f++)
        for(int j=0; j<size_y; j++)
            for(int i=0; i<size_x; i++)
                regression_image[f][j][i] = (_alpha[j][i] + _beta[j][i]*(float)f);

    for(int f=0; f<count; f++)
        regression_curve[f] = ikaros::mean(regression_image[f], size_x, size_y);
    
    destroy_matrix(_alpha);
    destroy_matrix(_beta);
}



- (void)calculatePixelPolyReg
{
    int a = [[data objectForKey: @"poly.a"] intValue];
    int b = [[data objectForKey: @"poly.b"] intValue];
    int c = [[data objectForKey: @"poly.c"] intValue];
    int d = [[data objectForKey: @"poly.d"] intValue];

    if(c>count)
        c = count;
    if(d > count)
        d = count;
    
    int s = (b-a)+(d-c);
    float ** _y = create_matrix(1, s);
    float ** _alpha = create_matrix(4, 1);
    float ** V = create_matrix(4, s);
 
    for(int j=0; j<size_y; j++)
        for(int i=0; i<size_x; i++)
        {
            int k = 0;
            
            for(int f=a; f<b; f++)
            {
                V[k][0] = 1;
                V[k][1] = float(f);
                V[k][2] = float(f)*float(f);
                V[k][3] = float(f)*float(f)*float(f);

                _y[k][0] = smooth_image[f][j][i];
                
                k++;
            }
            
            for(int f=c; f<d; f++)
            {
                V[k][0] = 1;
                V[k][1] = float(f);
                V[k][2] = float(f)*float(f);
                V[k][3] = float(f)*float(f)*float(f);

                _y[k][0] = smooth_image[f][j][i];
                
                k++;
            }
            
            ikaros::mldivide(_alpha, V, _y, 1, 4, s);
            
            for(int f=0; f<count; f++)
                regression_image[f][j][i] = _alpha[0][0] + _alpha[0][1]*(float)f + _alpha[0][2]*(float)f*(float)f + _alpha[0][3]*(float)f*(float)f*(float)f;
        }

    for(int f=0; f<count; f++)
        regression_curve[f] = ikaros::mean(regression_image[f], size_x, size_y);
    
    destroy_matrix(_alpha);
}



- (void)calculatePixelSignal
{
    double f_correction = [[data objectForKey: @"f.correction"] doubleValue];
    double image_mean = ikaros::mean(regression_image[count-1], size_x, size_y);
    double correction = f_correction*image_mean;
    
//    printf("CORRECTION: %lf %lf\n", f_correction, correction);
    
    int start = [[data objectForKey: @"stimulus.start"] intValue];
    if(start >= count)
        start = count;
        
    for(int f=0; f<start; f++)
        reset_matrix(signal_image[f], size_x, size_y);

    for(int f=start; f<count; f++)
        for(int j=0; j<size_y; j++)
            for(int i=0; i<size_x; i++)
            {
                if(regression_image[f][j][i] == 0)  // TODO: Test condition first
                    signal_image[f][j][i] = 0;
                else
                {
                    float v = (1-mask_image[j][i])*(smooth_image[f][j][i] - regression_image[f][j][i]) / (regression_image[f][j][i] - correction);
                    
                    signal_image[f][j][i] = v;
                }
            }
    
    for(int f=0; f<count; f++)
        signal_curve[f] = ikaros::mean(signal_image[f], size_x, size_y);
}



- (void)saveData
{
    if(dictionaryURL != nil)
        [data writeToURL: dictionaryURL atomically: YES];
}



- (void)measureInPoints
{
    reset_matrix(image_curve_in_point, count, 10);
    reset_matrix(regression_curve_in_point, count, 10);
    reset_matrix(signal_curve_in_point, count, 10);
 
    int measure_start = 0;
    int measure_end = count-1;
    
    if([data objectForKey: @"measure.start"] != nil)
        measure_start = [[data objectForKey: @"measure.start"] intValue];
    
    if([data objectForKey: @"measure.end"] != nil)
        measure_end = [[data objectForKey: @"measure.end"] intValue];
    
    if(measure_end > count-1)
        measure_end = count-1;
    
    double radius = [[data objectForKey: @"point.radius"] doubleValue];
    if(radius == 0)
        radius = 15; //default radius
    
    // check if active area should be calculated as well
    
    float area_frame = (measure_end-measure_start)/2; // reasonable default; maybe an error should be given?
    float area_threshold = 0;
    if([data objectForKey: @"point.area.threshold"] != nil)
        area_threshold = [[data objectForKey: @"point.area.threshold"] floatValue];

    if([data objectForKey: @"point.area.frame"] != nil)
        area_frame = [[data objectForKey: @"point.area.frame"] floatValue];

    for(int p=1; p<=10; p++)
    {
        [data removeObjectForKey: [NSString stringWithFormat: @"p%d.magnitude", p]];
        [data removeObjectForKey: [NSString stringWithFormat: @"p%d.area", p]];

        NSPoint center = [self point: p];
        
        if(center.x != 0)
        {
            // Calculate magnitude for the points
            
            double sum = 0;
            for(int i=measure_start; i<measure_end; i++)
            {
                double frame_sum = 0;
                double frame_n = 0;
                double frame_above_area_threshold = 0;

                 for(int x=0; x<size_x; x++)
                    for(int y=0; y<size_y; y++){
                        if(hypot((double)x-center.x, (double)y-center.y) < radius)
                        {
                            frame_sum += signal_image[i][y][x];
                            frame_above_area_threshold += (signal_image[i][y][x] > area_threshold ? 1.0 : 0.0);
                            frame_n += 1.0;
                        }

                    }
                if(frame_n > 0)
                {
                    sum += frame_sum / frame_n;
                    float area_fraction = frame_above_area_threshold / frame_n;
                    if(area_threshold > 0 && i == area_frame)
                    {
                        [data setObject: [NSString stringWithFormat: @"%.4lf", area_fraction] forKey: [NSString stringWithFormat: @"p%d.area", p]];
                    }
                }
            }
            
            [data setObject: [NSString stringWithFormat: @"%.4lf", sum]
                forKey: [NSString stringWithFormat: @"p%d.magnitude", p]];
            
            for(int f=0; f<count; f++)
            {
                double img_sum = 0;
                double reg_sum = 0;
                double sig_sum = 0;
                double n = 0;
                for(int x=0; x<size_x; x++)
                    for(int y=0; y<size_y; y++)
                        if(hypot((double)x-center.x, (double)y-center.y) < radius)
                        {
                            img_sum += smooth_image[f][y][x];
                            sig_sum += signal_image[f][y][x];
                            reg_sum += regression_image[f][y][x];
                            n += 1;
                        }
                        
                image_curve_in_point[p-1][f] = (n > 0 ? img_sum/n : 0);
                regression_curve_in_point[p-1][f] = (n > 0 ? reg_sum/n : 0);
                signal_curve_in_point[p-1][f] = (n > 0 ? sig_sum/n : 0);
            }
        }
    }
}



- (NSBitmapImageRep *)createPseudocolorImage: (int)frame
{
    float img_min = [[data objectForKey: @"image.min"] doubleValue];
    float img_max = [[data objectForKey: @"image.max"] doubleValue];
    float img_scale = (img_max != img_min ? 1/(img_max-img_min) : 1);
    
    float p_min = [[data objectForKey: @"pseudo.min"] doubleValue];
    float p_max = [[data objectForKey: @"pseudo.max"] doubleValue];
    float p_threshold = [[data objectForKey: @"pseudo.threshold"] doubleValue];
    float p_inv_diff = (p_max != p_min ? 1/(p_max-p_min) : 1);

    
    NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc]
                                 initWithBitmapDataPlanes:NULL
                                 pixelsWide:size_x
                                 pixelsHigh:size_y
                                 bitsPerSample:8
                                 samplesPerPixel:4
                                 hasAlpha:YES
                                 isPlanar:NO
                                 colorSpaceName:NSCalibratedRGBColorSpace
                                 bitmapFormat:0
                                 bytesPerRow:4*size_x
                                 bitsPerPixel:4*8];
    unsigned char *pix = [bitmap bitmapData];

    if(img_min == img_max)
        for(int i=0; i<size_x*size_y; i++)
        {
            pix[4*i]   = 0;
            pix[4*i+1] = 0;
            pix[4*i+2] = 0;
            pix[4*i+3] = 255;
        }

    if(p_min == p_max) // This should be taken care of below really....
        for(int i=0; i<size_x*size_y; i++)
        {
            unsigned char z = (unsigned char)(255.0*img_scale*(image[frame][0][i]-img_min));

            pix[4*i]   = z;
            pix[4*i+1] = z;
            pix[4*i+2] = z;
            pix[4*i+3] = 255;
        }

    else
        for(int i=0; i<size_x*size_y; i++)
        {
            float s = signal_image[frame][0][i];
            
            int v = (unsigned char)255;
            if(s <= p_min)
                v = (unsigned char)0;
            else if(s < p_max)
                v = (unsigned char)(255*((double)p_inv_diff*(s-p_min)));
            

            if(s > p_threshold)
            {
                pix[4*i]   = LUT_fire[v][0];
                pix[4*i+1] = LUT_fire[v][1];
                pix[4*i+2] = LUT_fire[v][2];
                pix[4*i+3] = 255;
            }
            else
            {
                unsigned char z = (unsigned char)(255.0*img_scale*(image[frame][0][i]-img_min));

                pix[4*i]   = z;
                pix[4*i+1] = z;
                pix[4*i+2] = z;
                pix[4*i+3] = 255;
            }
        }
    
    return bitmap;
}



- (NSBitmapImageRep *)createMaskImage
{
    NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc]
                                 initWithBitmapDataPlanes:NULL
                                 pixelsWide:size_x
                                 pixelsHigh:size_y
                                 bitsPerSample:8
                                 samplesPerPixel:4
                                 hasAlpha:YES
                                 isPlanar:NO
                                 colorSpaceName:NSCalibratedRGBColorSpace
                                 bitmapFormat:0
                                 bytesPerRow:4*size_x
                                 bitsPerPixel:4*8];
    unsigned char *pix = [bitmap bitmapData];

    for(int i=0; i<size_x*size_y; i++)
    {
        if(mask_image[0][i] > 0)
        {
            pix[4*i]   = 0;
            pix[4*i+1] = 255;
            pix[4*i+2] = 0;
            pix[4*i+3] = 128;
        }
        else
        {
            pix[4*i]   = 0;
            pix[4*i+1] = 0;
            pix[4*i+2] = 0;
            pix[4*i+3] = 0;
        }
    }

    return bitmap;
}



-(void)writePseudocolorImage
{
    int frame = [[data objectForKey: @"pseudo.frame"] intValue];
    if(frame == 0)
        frame = [[data objectForKey: @"signal.peak"] intValue];
    
    NSBitmapImageRep *bitmap = [self createPseudocolorImage:frame];   //**********
    NSData * tiffData = [bitmap TIFFRepresentation];
    
    NSURL * url = [[tiffURL URLByDeletingPathExtension] URLByAppendingPathExtension: @"processed.tiff"];
    [tiffData writeToURL: url atomically: YES];
}



- (void)calculateMSE
{
    int measure_start = 0;
    int measure_end = count-1;
    
    if([data objectForKey: @"measure.start"] != nil)
        measure_start = [[data objectForKey: @"measure.start"] intValue];
    
    if([data objectForKey: @"measure.end"] != nil)
        measure_end = [[data objectForKey: @"measure.end"] intValue];
    
    if(measure_end > count-1)
        measure_end = count-1;

    float err = 0;
    float werr = 0;
    float c = 0;
    float wc = 0;
    
    for(int i=0; i<count; i++)
    {
        float se = ikaros::sqr(image_curve[i] - regression_curve[i]);
        err += se;
        c += 1;
        if(i < measure_start ||  i >= measure_end)
        {
            werr += se;
            wc += 1;
        }
    }
    
    if(c > 0)
        [data setObject: [NSString stringWithFormat: @"%.4lf", err/c] forKey: [prefix stringByAppendingString: @"MSE"]];

    if(wc > 0)
        [data setObject: [NSString stringWithFormat: @"%.4lf", werr/wc] forKey: [prefix stringByAppendingString: @"MSEW"]];
}



- (void)processUsingOneMethod
{
    // Pre-process
    
    [self calculateImageMinMaxAndCurve];
    [self smoothImages];
    [self calculateMask];
    
    // Process each pixel
    
    NSString * m = [data objectForKey: @"reg.method"];
    
    if([m isEqualToString: @"constant"])
        [self calculatePixelConstReg];
    
    else if([m isEqualToString: @"linear"])
        [self calculatePixelLinReg];

    else if([m isEqualToString: @"polynomial"])
        [self calculatePixelPolyReg];

   else if([m isEqualToString: @"band-pass"])
        [self calculatePixelBandPassReg];

    [self calculatePixelSignal];
    
    [self calculateSignalMinMaxAndCurve];
    [self calculateSignalMeasurements];
    
    [self calculateSignalMeasurements];

    [self calculateMSE];
    [self calculatePseudoLevels];

    [self measureInPoints];
    
    [self saveData];
    [self writePseudocolorImage];
}



- (void)process
{
    NSString * m = [data objectForKey: @"reg.method"];
    
    if([m isEqualToString: @"all"])
    {
        prefix = @"const.";
        [data setObject: @"constant" forKey: @"reg.method"];
        [self processUsingOneMethod];
        
        prefix = @"poly.";
        [data setObject: @"polynomial" forKey: @"reg.method"];
        [self processUsingOneMethod];
        
        prefix = @"bp.";
        [data setObject: @"band-pass" forKey: @"reg.method"];
        [self processUsingOneMethod];

        prefix = @"lin.";
        [data setObject: @"linear" forKey: @"reg.method"];
        [self processUsingOneMethod];
        
        [data setObject: @"all" forKey: @"reg.method"];
    }
    
    else
        [self processUsingOneMethod];
}



- (void)applyTemplate
{
    NSError *err;

    // Search for template
    
    NSURL * templateURL = [[tiffURL URLByDeletingLastPathComponent] URLByAppendingPathComponent: @"Template.plist"];
    while(![templateURL checkResourceIsReachableAndReturnError:&err] && ![[templateURL absoluteString] isEqualToString:@"file:///Template.plist"] && ![[templateURL absoluteString] isEqualToString:@"file://localhost/Template.plist"] && ![[templateURL absoluteString] isEqualToString:@"file:///Volumes/Template.plist"])
    {
        templateURL = [[[templateURL URLByDeletingLastPathComponent] URLByDeletingLastPathComponent] URLByAppendingPathComponent: @"Template.plist"];
        NSLog(@"%@", templateURL);
    }

    // Load template and merge with data
    
    if(![templateURL checkResourceIsReachableAndReturnError:&err])
        return; // no template found
        
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfURL: templateURL];
    [data addEntriesFromDictionary: dict];
    
    // Add metadata from filename
    
    NSArray * path = [[tiffURL path] pathComponents];        
    NSArray * keys = [data allKeys];
    NSArray * values = [data allValues];
    
    // Add metadata from path
    
    for(int i=0; i< keys.count; i++)
    {
        NSString * v = [values objectAtIndex: i];
        NSRange range = [v rangeOfString: @"=PATH("];
        if(range.location != NSNotFound)
        {
            NSString * s = [v substringFromIndex: range.length];
            NSArray * a = [s componentsSeparatedByString: @","];
            if(a.count == 3)
            {
                int index = [[a objectAtIndex: 0] intValue];
                int first = [[a objectAtIndex: 1] intValue];
                int len = [[a objectAtIndex: 2] intValue];
                
                NSString * segment = [path objectAtIndex: [path count]-index-1];
                
                if(segment == nil)
                    [data setObject: @"#PATH_INDEX-ERROR#" forKey: [keys objectAtIndex: i]];
                else if(first+len > [segment length])
                    [data setObject: @"#RANGE-ERROR#" forKey: [keys objectAtIndex: i]];
                else
                {
                    NSString * value = [[segment substringWithRange: NSMakeRange(first, len)] uppercaseString];
                    [data setObject: value forKey: [keys objectAtIndex: i]];
                }
            }
            else
                [data setObject: @"#FORMAT-ERROR#" forKey: [keys objectAtIndex: i]];
        }
    }
    
    // Add metadata from filename
    
    for(int i=0; i< keys.count; i++)
    {
        NSString * v = [values objectAtIndex: i];
        NSRange range = [v rangeOfString: @"=FILENAME("];
        if(range.location != NSNotFound)
        {
            NSString * s = [v substringFromIndex: range.length];
            NSArray * a = [s componentsSeparatedByString: @","];
            if(a.count == 2)
            {
                int first = [[a objectAtIndex: 0] intValue];
                int len = [[a objectAtIndex: 1] intValue];
                if(first+len > [[tiffURL lastPathComponent] length])
                    [data setObject: @"#RANGE-ERROR#" forKey: [keys objectAtIndex: i]];
                else
                {
                    NSString * value = [[tiffURL lastPathComponent] substringWithRange: NSMakeRange(first, len)];
                    [data setObject: value forKey: [keys objectAtIndex: i]];
                }
            }
            else
                [data setObject: @"#FORMAT-ERROR#" forKey: [keys objectAtIndex: i]];
        }
    }
    
    // Add metadata from computation =COMPUTE(variable, scale, add)
    
    for(int i=0; i< keys.count; i++)
    {
        NSString * v = [values objectAtIndex: i];
        NSRange range = [v rangeOfString: @"=COMPUTE("];
        if(range.location != NSNotFound)
        {
            NSString * s = [v substringFromIndex: range.length];
            NSArray * a = [s componentsSeparatedByString: @","];
            if(a.count == 3)
            {
                NSString * var = [a objectAtIndex: 0];
                
                double x = [[data objectForKey: var] doubleValue];
                double scale = [[a objectAtIndex: 1] doubleValue];
                double add = [[a objectAtIndex: 2] doubleValue];
                
                double computed_value = scale*x+add;
                
                printf("computer_value %lf\n", computed_value);
                
                [data setObject: [NSString stringWithFormat: @"%lf", computed_value] forKey: [keys objectAtIndex: i]];
            }
            else
                [data setObject: @"#FORMAT-ERROR#" forKey: [keys objectAtIndex: i]];
        }
    }
}



- (void)clear
{
    data = [NSMutableDictionary dictionaryWithCapacity: 32];
    [self applyTemplate];
}



- (void)processUsingTemplate
{
    [self applyTemplate];
    [self process];
}



- (id)initWithTIFF: (NSURL *)fileURL usingTemplate: (BOOL)useTemplate
{
    NSError *err;

    if ((self = [super init]))
    {
        // Init data structures
        
        prefix = @"";
        alpha = NULL;
        beta = NULL;

        activityHistogram = (double *)calloc(256, sizeof(double));
        for(int i=0; i<256; i++)
            activityHistogram[i] = 0;

        tiffURL = [fileURL copy];
        dictionaryURL = [[fileURL URLByDeletingPathExtension] URLByAppendingPathExtension: @"optdata"];
        pointsURL = [[tiffURL URLByDeletingLastPathComponent] URLByAppendingPathComponent: @"Points.plist"];
        
        // Read source TIFF
        
        sourceTIFF = [[NSImage alloc] initByReferencingURL: fileURL];
        
        NSImageRep * imageRep0 = [sourceTIFF.representations objectAtIndex: 0];

        int width = [imageRep0 pixelsWide];
        int height = [imageRep0 pixelsHigh];
        count = (unsigned long)[sourceTIFF.representations count];
        
        // Create low-level data structures
        
        size_x = width;
        size_y = height;
        
        image = create_matrix(size_x, size_y, count);
        smooth_image = create_matrix(size_x, size_y, count);
        regression_image = create_matrix(size_x, size_y, count);
        signal_image = create_matrix(size_x, size_y, count);
        mask_image = create_matrix(size_x, size_y);
        
        image_curve = create_array(count);
        regression_curve = create_array(count);
        signal_curve = create_array(count);
        
        image_curve_in_point = create_matrix(count, 10);
        regression_curve_in_point = create_matrix(count, 10);
        signal_curve_in_point = create_matrix(count, 10);

        for(int k=0; k<count; k++)
        {
            NSBitmapImageRep * image_rep = [sourceTIFF.representations objectAtIndex: k];

            UInt16 *pixels = (UInt16 *)[image_rep bitmapData];
            for(int i=0; i<size_x*size_y; i++)
                image[k][0][i] = (float)(pixels[i]);
        }

        // Load data from plist for this file if it exists or create new data dictionary
        
        if([dictionaryURL checkResourceIsReachableAndReturnError:&err])
        {
            data = [NSMutableDictionary dictionaryWithContentsOfURL: dictionaryURL];
            if(useTemplate)
                [self applyTemplate];
        }
        else
        {
            data = [NSMutableDictionary dictionaryWithCapacity:16];
            
            [data setObject: [fileURL absoluteString] forKey: @"file"];
            
            [data setObject: @"1" forKey: @"include"];
            [data setObject: @"0.15" forKey: @"mask.fraction"];
            [data setObject: @"2" forKey: @"filter.radius"];
            [data setObject: @"12"  forKey: @"stimulus.start"];
            [data setObject: @"20"  forKey: @"stimulus.end"];
            [data setObject: @"10"  forKey: @"measure.start"];
            [data setObject: @"30"  forKey: @"measure.end"];
            
            [data setObject: @"linear"  forKey: @"reg.method"];

            [data setObject: @"0.020"  forKey: @"pseudo.max"];
            [data setObject: @"0.010"  forKey: @"pseudo.min"];
            [data setObject: @"0.015"  forKey: @"pseudo.threshold"];

            [data setObject: @"0.25"  forKey: @"draw.threshold"];
                                    
            // Set default regression parameters
            
            [data setObject: @"3"  forKey: @"bp.a"];

            [data setObject: @"5"  forKey: @"const.a"];
            [data setObject: @"10" forKey: @"const.b"];

            [data setObject: @"5"  forKey: @"lin.a"];

            [data setObject: @"10" forKey: @"lin.b"];
            [data setObject: [NSString stringWithFormat: @"%d", count-5] forKey: @"lin.c"];
            [data setObject: [NSString stringWithFormat: @"%d", count] forKey: @"lin.d"];

            [data setObject: @"0"  forKey: @"poly.a"];
            [data setObject: @"10" forKey: @"poly.b"];
            [data setObject: [NSString stringWithFormat: @"%d", count-5] forKey: @"poly.c"];
            [data setObject: [NSString stringWithFormat: @"%d", count] forKey: @"poly.d"];

            [self applyTemplate];
        }
 
        // Load points dictionary if it exists
        
        if([pointsURL checkResourceIsReachableAndReturnError:&err])
            points = [NSMutableDictionary dictionaryWithContentsOfURL: pointsURL];
        else
            points = nil;

        [data setObject: [NSString stringWithFormat: @"%d", count]  forKey: @"image.count"];
        [data setObject: [NSString stringWithFormat: @"%ld", (long)[imageRep0 bitsPerSample]] forKey: @"image.bits"];
        [data setObject: [NSString stringWithFormat: @"%d", width] forKey: @"image.width"];
        [data setObject: [NSString stringWithFormat: @"%d", height] forKey: @"image.height"];


        [self process];
    }

    return self;
}



- (void)dealloc
{
    NSLog(@"OpticalImage dealloc");

    free(alpha);
    free(beta);

    destroy_matrix(image);
    destroy_matrix(smooth_image);
    destroy_matrix(regression_image);
    destroy_matrix(signal_image);
    destroy_matrix(mask_image);
    
    destroy_matrix(image_curve_in_point);
    destroy_matrix(regression_curve_in_point);
    destroy_matrix(signal_curve_in_point);

    destroy_array(image_curve);
    destroy_array(regression_curve);
    destroy_array(signal_curve);
}



// Manage points

- (void)addPoint:(int)p atX:(double)x andY:(double)y
{
    NSError *err;
    
    if(p > 10)
        return;
    
    // Load points data if any

    if([pointsURL checkResourceIsReachableAndReturnError:&err])
        points = [NSMutableDictionary dictionaryWithContentsOfURL: pointsURL];
    else
        points = [NSMutableDictionary dictionaryWithCapacity: 16] ;
    
    // Add new point (or modify old)
    
    [points setObject: [NSNumber numberWithDouble: x] forKey: [NSString stringWithFormat: @"p%d.x", p]];
    [points setObject: [NSNumber numberWithDouble: y] forKey: [NSString stringWithFormat: @"p%d.y", p]];
    
    // Save points data
    
    if(pointsURL != nil)
        [points writeToURL: pointsURL atomically: YES];
    
    [self measureInPoints];
}



- (void)removePointAtX:(double)x andY:(double)y
{
    NSError *err;
    
    // Load points data if any

    if([pointsURL checkResourceIsReachableAndReturnError:&err])
        points = [NSMutableDictionary dictionaryWithContentsOfURL: pointsURL];
    else
        points = [NSMutableDictionary dictionaryWithCapacity: 16] ;
    
    double r = [[data objectForKey: @"point.radius"] doubleValue];

    // Find closest point
    
    int k = 0;
    double minr = 99999;
    for(int p=1; p<=10; p++)
    {
        double px = [[points objectForKey: [NSString stringWithFormat: @"p%d.x", p]] doubleValue];
        double py = [[points objectForKey: [NSString stringWithFormat: @"p%d.y", p]] doubleValue];

        if(hypot(px-x, py-y) <= r && r < minr)
        {
            k = p;
            minr = r;
        }
    }

    if(k == 0)
        return;

    [points removeObjectForKey: [NSString stringWithFormat: @"p%d.x", k]];
    [points removeObjectForKey: [NSString stringWithFormat: @"p%d.y", k]];

    // Save points data
    
    if(pointsURL != nil)
        [points writeToURL: pointsURL atomically: YES];
    
    [self measureInPoints];
}



- (void)removeAllPoints
{
    points = [NSMutableDictionary dictionaryWithCapacity: 16] ;
    if(pointsURL != nil)
        [points writeToURL: pointsURL atomically: YES];
}



- (void)loadPoints
{
    NSError *err;

    if([pointsURL checkResourceIsReachableAndReturnError:&err])
        points = [NSMutableDictionary dictionaryWithContentsOfURL: pointsURL] ;
    else
        points = [NSMutableDictionary dictionaryWithCapacity: 16];
}



- (NSPoint)point:(int)p
{
    double x = [[points objectForKey: [NSString stringWithFormat: @"p%d.x", p]] doubleValue];
    double y = [[points objectForKey: [NSString stringWithFormat: @"p%d.y", p]] doubleValue];
    return NSMakePoint(x, y);
}

@end
