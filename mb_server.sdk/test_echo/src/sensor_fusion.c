/*
 * sensor_fusion.c
 *
 *  Created on: May 4, 2019
 *      Author: felip
 */

#include <math.h>
#include "sensor_fusion.h"


double calculateMEAN(double data[], size_t len)
{
	double sum = 0.0, mean;

	int i;

	for(i=0; i<len; ++i)
	{
		sum += data[i];
	}

	mean = sum/len;

	return mean;
}


double calculateVAR(double data[], double mean, size_t len)
{
    double variance = 0.0;

    int i;

    for(i=0; i<len; ++i)
        variance += pow(data[i] - mean, 2);

    return variance/len;
}

double getFusionData(double data1[], size_t len1, double data2[], size_t len2)
{
	double mean1 = calculateMEAN(data1, len1);
	double mean2 = calculateMEAN(data2, len2);
	double var1 = calculateVAR(data1, mean1, len1);
	double var2 = calculateVAR(data2, mean2, len2);

	double fusionMean = ((mean1 * var2) + (mean2 * var1)) / (sqrt(var1 * var2));

	return fusionMean;
}
