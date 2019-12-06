/*
 * Copyright 2019-present Open Networking Foundation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define _PKT_OUT_HDR_ANNOT @not_extracted_in_egress

#define _BOOL bit<1>
#define _TRUE 1w1
#define _FALSE 1w0

#ifdef WITH_INT_TRANSIT
#define _PRE_INGRESS fabric_metadata.int_meta.ig_tstamp = (bit<32>) standard_metadata.ingress_global_timestamp;
#define _PRE_EGRESS fabric_metadata.int_meta.eg_tstamp = (bit<32>) standard_metadata.egress_global_timestamp;
#endif // WITH_INT_TRANSIT

#define _INT_INIT_METADATA \
    hdr.int_switch_id.switch_id = switch_id;\
    hdr.int_port_ids.ingress_port_id = (bit<16>) smeta.ingress_port;\
    hdr.int_port_ids.egress_port_id = (bit<16>) smeta.egress_port;\
    hdr.int_ingress_tstamp.ingress_tstamp = fmeta.int_meta.ig_tstamp;\
    hdr.int_egress_tstamp.egress_tstamp = fmeta.int_meta.eg_tstamp;\
    hdr.int_hop_latency.hop_latency = (bit<32>) smeta.egress_global_timestamp - (bit<32>) smeta.ingress_global_timestamp;\
    hdr.int_q_occupancy.q_id = 8w0;\
    hdr.int_q_occupancy.q_occupancy = (bit<24>) smeta.deq_qdepth;\
    hdr.int_q_congestion.q_id = 8w0;\
    hdr.int_q_congestion.q_congestion = 24w0;\
    hdr.int_egress_tx_util.egress_port_tx_util = 32w0;\

#define _INT_METADATA_ACTIONS \
    action int_set_header_0() { hdr.int_switch_id.setValid(); }\
    action int_set_header_1() { hdr.int_port_ids.setValid(); }\
    action int_set_header_2() { hdr.int_hop_latency.setValid(); }\
    action int_set_header_3() { hdr.int_q_occupancy.setValid(); }\
    action int_set_header_4() { hdr.int_ingress_tstamp.setValid(); }\
    action int_set_header_5() { hdr.int_egress_tstamp.setValid(); }\
    action int_set_header_6() { hdr.int_q_congestion.setValid(); }\
    action int_set_header_7() { hdr.int_egress_tx_util.setValid(); }\

#define __TABLE_SIZE__
#define BNG_MAX_SUBSC 1024
#define BNG_MAX_NET_PER_SUBSC 4
#define BNG_MAX_SUBSC_NET BNG_MAX_NET_PER_SUBSC * BNG_MAX_SUBSC
#ifdef WITH_BNG
    #define PORT_VLAN_TABLE_SIZE BNG_MAX_SUBSC + 2048
#else
    #define PORT_VLAN_TABLE_SIZE 2048
#endif // WITH_BNG
#define FWD_CLASSIFIER_TABLE_SIZE 128
#define BRIDGING_TABLE_SIZE 2048
#define MPLS_TABLE_SIZE 2048
#ifdef WITH_BNG
    #define ROUTING_V4_TABLE_SIZE BNG_MAX_SUBSC_NET + 1024
#else
    #define ROUTING_V4_TABLE_SIZE 30000
#endif // WITH_BNG
#define ACL_TABLE_SIZE 2048
// Depends on number of unique next_id expected
#define NEXT_VLAN_TABLE_SIZE 2048
#define XCONNECT_NEXT_TABLE_SIZE 4096
#define SIMPLE_NEXT_TABLE_SIZE 2048
#define HASHED_NEXT_TABLE_SIZE 2048
// Max size of ECMP groups
#define HASHED_SELECTOR_MAX_GROUP_SIZE 16
// Ideally HASHED_NEXT_TABLE_SIZE * HASHED_SELECTOR_MAX_GROUP_SIZE
#define HASHED_ACT_PROFILE_SIZE 32w32768
#define MULTICAST_NEXT_TABLE_SIZE 2048
#define EGRESS_VLAN_TABLE_SIZE 2048

#define _ROUTING_V4_TABLE_ANNOT @alpm(1)

#include "fabric.p4"
