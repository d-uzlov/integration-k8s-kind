// Copyright (c) 2022 Cisco and/or its affiliates.
//
// SPDX-License-Identifier: Apache-2.0
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at:
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package single

import (
	"flag"
	"testing"

	"github.com/stretchr/testify/suite"

	"github.com/networkservicemesh/integration-tests/suites/features"
)

var calicoFlag = flag.Bool("calico", false, "selects calico tests")

// Disabled tests for Calico-vpp:
// TestMutually_aware_nses - https://github.com/networkservicemesh/integration-k8s-kind/issues/627
// TestNse_composition     - https://github.com/networkservicemesh/integration-k8s-kind/issues/625
// TestVl3_basic           - https://github.com/networkservicemesh/integration-k8s-kind/issues/633
// TestVl3_scale_from_zero - https://github.com/networkservicemesh/integration-k8s-kind/issues/633
type calicoFeatureSuite struct {
	features.Suite
}

func (s *calicoFeatureSuite) BeforeTest(suiteName, testName string) {
	switch testName {
	case
		"TestMutually_aware_nses",
		"TestNse_composition",
		"TestVl3_basic",
		"TestVl3_scale_from_zero":
		s.T().Skip()
	}
	s.Suite.BeforeTest(suiteName, testName)
}

func TestRunFeatureSuite(t *testing.T) {
	if *calicoFlag {
		suite.Run(t, new(calicoFeatureSuite))
	} else {
		suite.Run(t, new(features.Suite))
	}
}
