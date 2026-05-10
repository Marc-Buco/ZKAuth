#!/bin/bash

# Configuration
CIRCUIT_NAME="membership"
PTAU_PATH="powersOfTau28_hez_final_12.ptau"

echo "--- 1. Generate Witness ---"
node build/membership_js/generate_witness.js build/membership_js/membership.wasm inputs.json build/witness.wtns

echo "--- 2. Generate Proof and Public Signals ---"
npx snarkjs groth16 prove build/membership_final.zkey build/witness.wtns build/proof.json build/public.json

echo "--- 3. Export Verifier Contract ---"
npx snarkjs zkey export solidityverifier build/membership_final.zkey contracts/Verifier.sol



echo "--- Done! --"