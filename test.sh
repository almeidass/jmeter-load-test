#!/bin/bash
#
# Test the JMeter Docker image using a trivial test plan.

T_DIR=test-plans/blaze-demo

# Reporting dir: start fresh
R_DIR=${T_DIR}/report
rm -rf ${R_DIR} >/dev/null 2>&1
mkdir -p ${R_DIR}

/bin/rm -f ${T_DIR}/blaze-demo-plugins.jtl ${T_DIR}/jmeter.log >/dev/null 2>&1

./run.sh -Dlog_level.jmeter=DEBUG \
	-n -t ${T_DIR}/blaze-demo-plugins.jmx -l ${T_DIR}/blaze-demo-plugins.jtl -j ${T_DIR}/jmeter.log \
	-e -o ${R_DIR}
