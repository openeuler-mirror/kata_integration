#!/bin/bash

# Copyright (c) Huawei Technologies Co., Ltd. 2019. All rights reserved.
# kata_integration is licensed under the Mulan PSL v2.
# You can use this software according to the terms and conditions of the Mulan PSL v2.
# You may obtain a copy of Mulan PSL v2 at:
#     http://license.coscl.org.cn/MulanPSL2
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR
# PURPOSE.
# See the Mulan PSL v2 for more details.
# Description: build kata runtime
# Author: caihaomin
# Create: 2019-01-22

# This helper script builds kata-runtime.
# Golang needs this crazy directory structure environment.
#

KATA_RUNTIME_PATH=$(readlink -f $1)
if [ -z $KATA_RUNTIME_PATH ];then
    echo "get KATA_RUNTIME_PATH failed"
    exit 1
fi

rm -rf /tmp/kata-build/
mkdir -p /tmp/kata-build/
GOPATH=/tmp/kata-build/
BASE=$GOPATH/src/github.com/kata-containers/

mkdir -p $BASE
ln -s $KATA_RUNTIME_PATH $BASE/runtime

export GOPATH=$(readlink -f $GOPATH)
cd ${BASE}/runtime && \
        make clean && \
        make
rm -rfv $GOPATH > /dev/null
