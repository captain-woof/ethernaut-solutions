# README

What the hack contract does is that it bruteforces the amount of gas to send to the target contract's `enter(bytes8 _gateKey)` function after calculating the key to send (by bit-masking).

To complete the level, study my hack contract, deploy it on Rinkeby, and run the `hack()` function. It should succeed with a bruteforced gas value of 254.

## Running

To run the hack contract locally, run:
```
yarn brute
```

To deploy the hack contract on Rinkeby, run:
```
yarn deploy
```

## Environment variables
Put these in the `.env` file.

```
PRIVATE_KEY="XXXXXXXXXXXXXXX..."
ETHERSCAN_API_KEY="XXXXXXXX...."
```
