/*
 * sensor_fusion.h
 *
 *  Created on: May 9, 2019
 *      Author: felip
 */

#ifndef SRC_SENSOR_FUSION_H_
#define SRC_SENSOR_FUSION_H_

double calculateMEAN(double data[], size_t len);
double calculateVAR(double data[], double mean, size_t len);
double getFusionData(double data1[], size_t len1, double data2[], size_t len2);

#endif /* SRC_SENSOR_FUSION_H_ */
