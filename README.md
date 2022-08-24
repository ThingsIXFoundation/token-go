# ThixM token go bindings
This repository holds go bindings to interact with the ThixM token contract.

## Generate bindings
Run `go generate` from the root of the project. This will checkout the smart
contract repository in a temporarly work directory and extracts the ABI from the
ThixM token contract and feeds it to abigen to generate the bindings. The
bindings are stored in the `thixm` package.

The smart contract evm repository is a private repository and the user that
runs the generate command needs to be able to clone this private repository.