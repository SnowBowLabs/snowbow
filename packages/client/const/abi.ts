export const SNOWBOW_PRODUCT_ABI = [{ "inputs": [{ "internalType": "address", "name": "target", "type": "address" }], "name": "AddressEmptyCode", "type": "error" }, { "inputs": [{ "internalType": "address", "name": "account", "type": "address" }], "name": "AddressInsufficientBalance", "type": "error" }, { "inputs": [], "name": "Claimed", "type": "error" }, { "inputs": [], "name": "FailedInnerCall", "type": "error" }, { "inputs": [], "name": "InvalidTokenParams", "type": "error" }, { "inputs": [{ "internalType": "address", "name": "token", "type": "address" }], "name": "SafeERC20FailedOperation", "type": "error" }, { "inputs": [], "name": "SnowbowNotEnded", "type": "error" }, { "inputs": [], "name": "SnowbowStarted", "type": "error" }, { "anonymous": false, "inputs": [{ "indexed": true, "internalType": "address", "name": "user", "type": "address" }, { "indexed": false, "internalType": "uint256", "name": "usdAmount", "type": "uint256" }, { "indexed": false, "internalType": "uint256", "name": "targetAmount", "type": "uint256" }], "name": "BuyShare", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": true, "internalType": "address", "name": "product", "type": "address" }, { "indexed": false, "internalType": "uint256", "name": "triggerPrice", "type": "uint256" }], "name": "KnockIn", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": true, "internalType": "address", "name": "product", "type": "address" }, { "indexed": false, "internalType": "uint256", "name": "triggerPrice", "type": "uint256" }], "name": "KnockOut", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": true, "internalType": "address", "name": "product", "type": "address" }, { "indexed": false, "internalType": "uint256", "name": "currentPrice", "type": "uint256" }], "name": "PriceCheck", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": true, "internalType": "address", "name": "product", "type": "address" }, { "indexed": false, "internalType": "enum IStructDef.SnowbowResultStatus", "name": "currentStatus", "type": "uint8" }], "name": "ProductStatusChange", "type": "event" }, { "inputs": [], "name": "_baseProfit", "outputs": [{ "internalType": "uint16", "name": "", "type": "uint16" }], "stateMutability": "view", "type": "function" }, { "inputs": [{ "internalType": "address", "name": "", "type": "address" }], "name": "_boughtAmount", "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "_period", "outputs": [{ "internalType": "uint32", "name": "", "type": "uint32" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "_priceObserver", "outputs": [{ "internalType": "address", "name": "", "type": "address" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "_startTime", "outputs": [{ "internalType": "uint32", "name": "", "type": "uint32" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "_targetDecimal", "outputs": [{ "internalType": "uint8", "name": "", "type": "uint8" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "_targetInitPrice", "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "_targetKnockInPrice", "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "_targetKnockOutPrice", "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "_targetToken", "outputs": [{ "internalType": "address", "name": "", "type": "address" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "_targetTokenFeeData", "outputs": [{ "internalType": "address", "name": "", "type": "address" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "_usdFeeData", "outputs": [{ "internalType": "address", "name": "", "type": "address" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "_usdToken", "outputs": [{ "internalType": "address", "name": "", "type": "address" }], "stateMutability": "view", "type": "function" }, { "inputs": [{ "internalType": "uint256", "name": "amount", "type": "uint256" }], "name": "buyShare", "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "claimReward", "outputs": [{ "internalType": "uint256", "name": "reward", "type": "uint256" }], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [{ "internalType": "address", "name": "priceFeed", "type": "address" }], "name": "getLatestPrice", "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }], "stateMutability": "view", "type": "function" }, { "inputs": [{ "components": [{ "internalType": "address", "name": "targetToken", "type": "address" }, { "internalType": "address", "name": "targetTokenFeeData", "type": "address" }, { "internalType": "uint256", "name": "targetInitPrice", "type": "uint256" }, { "internalType": "uint256", "name": "targetKnockInPrice", "type": "uint256" }, { "internalType": "uint256", "name": "targetKnockOutPrice", "type": "uint256" }, { "internalType": "uint256", "name": "startTime", "type": "uint256" }, { "internalType": "uint256", "name": "period", "type": "uint256" }, { "internalType": "uint256", "name": "baseProfit", "type": "uint256" }, { "internalType": "address", "name": "usdToken", "type": "address" }, { "internalType": "address", "name": "usdFeeData", "type": "address" }, { "internalType": "address", "name": "priceObserver", "type": "address" }], "internalType": "struct IStructDef.ProductInitArgs", "name": "args", "type": "tuple" }], "name": "initialize", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "totalBoughtAmount", "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }], "stateMutability": "view", "type": "function" }]