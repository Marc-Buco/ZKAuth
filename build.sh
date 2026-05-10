#!/bin/bash

# Configuration
CIRCUIT_NAME="membership"
PTAU_PATH="powersOfTau28_hez_final_12.ptau"

echo "--- 1. Compiling Circuit ---"
circom circuits/$CIRCUIT_NAME.circom --r1cs --wasm --sym --output ./build

echo "--- 2. Generating Phase 2 (Circuit Specific) Setup ---"
# This links the universal randomness (ptau) to your specific circuit
npx snarkjs groth16 setup build/$CIRCUIT_NAME.r1cs $PTAU_PATH build/${CIRCUIT_NAME}_0000.zkey

echo "--- 3. Adding Entropy (The 'Ceremony' contribution) ---"
# In a real setup, many people do this. Here, we're simulating it.
echo "test" | npx snarkjs zkey contribute build/${CIRCUIT_NAME}_0000.zkey build/${CIRCUIT_NAME}_final.zkey --name="Marc's Master Project" -v

echo "--- 4. Exporting Verification Key ---"
npx snarkjs zkey export verificationkey build/${CIRCUIT_NAME}_final.zkey build/verification_key.json

echo "--- Done! Build files are in the /build folder ---"