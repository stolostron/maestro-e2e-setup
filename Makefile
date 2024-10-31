SHELL:=/bin/bash

rosa/setup-maestro:
	./rosa/setup/maestro.sh
.PHONY: rosa/setup-maestro

rosa/setup-agent:
	./rosa/setup/agent.sh
.PHONY: rosa/setup-agent

rosa/setup-e2e:
	./rosa/setup/e2e.sh
.PHONY: rosa/setup-e2e

rosa/teardown:
	./rosa/teardown.sh
.PHONY: rosa/teardown
