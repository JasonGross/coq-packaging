# Current coq version
COQ_VERSION ?= $(shell /usr/bin/coqc --version | grep version | sed 's/^.*version \(.*\) ([^)]*)$/\1/')

# Current coq ABI
COQ_ABI ?= $(shell cat /usr/lib/coq/abi)

# Standard library path
COQ_STDLIB_DIR ?= $(shell /usr/bin/coqc -where)

# Directory for contributions
# External libraries should go there
COQ_USERCONTRIB_DIR ?= $(COQ_STDLIB_DIR)/user-contrib
