# ThingsIX token go bindings
This repository contains go bindings to interact with the `ThixM` and `Thix`
token contracts.

## Generate bindings
Run `go generate` from the root of the project. This will checkout the smart
contract repository in a temporarly work directory and extracts the ABI from the
token contracts and feeds it to abigen to generate the bindings. The bindings
are stored in the `thixm` and `thix` packages.

# Prerequisites
The user needs to have access to the ThingsIX smart contract repository and
needs to have `go` and `abigen` installed.