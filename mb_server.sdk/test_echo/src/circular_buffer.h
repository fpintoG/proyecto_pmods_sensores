/*
 * circular_buffer.h
 *
 *  Created on: May 9, 2019
 *      Author: felip
 */

#ifndef SRC_CIRCULAR_BUFFER_H_
#define SRC_CIRCULAR_BUFFER_H_

typedef struct {
    double * const buffer;
    int head;
    int tail;
    const int maxlen;
} circ_bbuf_t;

int circ_bbuf_push(circ_bbuf_t *c, double data);
int circ_bbuf_pop(circ_bbuf_t *c, double *data);
int isBufferFull(circ_bbuf_t c);

#endif /* SRC_CIRCULAR_BUFFER_H_ */
