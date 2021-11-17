DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
CONFIG_PATH=$DIR/config.yml
KEYPAIRS=$DIR/keypairs
TEST_CREATOR=$KEYPAIRS/test-creator-keypair.json


echo
echo "+++ Stopping currently running Test Validator"
killall solana-test-validator > /dev/null && sleep 1

echo
echo "+++ Preparing Test Validator Config"
$DIR/prepare-config

echo
echo "+++ Starting Test Validator"
solana-test-validator -C $CONFIG_PATH -r > /dev/null &
sleep 2

echo
echo "+++ Airdropping us some more Funds"
solana -C $CONFIG_PATH airdrop 2000

PUBKEY=$(solana-keygen -C $CONFIG_PATH pubkey)
echo
echo "Account Pubkey is '$PUBKEY'"
echo "Account Keypair is'$(solana -C $CONFIG_PATH config get keypair | awk '{print $3}')"
echo "Account Info $(solana -C $CONFIG_PATH account $PUBKEY)"

echo
echo "Deploying Metaplex Programs"
$DIR/deploy-programs.sh

echo
echo "+++ DONE"
echo "To perform manual tests run"
echo "    cat $TEST_CREATOR"
echo "to log private key of test-creator and import it into your Browser Wallet"
