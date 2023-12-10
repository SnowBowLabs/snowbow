import { Address, BigDecimal, BigInt } from "@graphprotocol/graph-ts";
import {
  BuyShare,
  SnowbowProduct,
} from "../generated/templates/SnowbowProduct/SnowbowProduct";
import { Product, User, UserProduct } from "../generated/schema";

export const ETHER_DECIMAL = BigDecimal.fromString("1000000000000000000");
export const PRICE_DECIMAL_BIG_DECIMAL = BigDecimal.fromString("100000000");
export const YIELD_RATE_DECIMAL_BIG_DECIMAL = BigDecimal.fromString("10000");

export function handleBuyShare(event: BuyShare): void {
  const user = fetchUser(event.params.user);
  const product = fetchProduct(event.address);

  const up = fetchUserProduct(user, product);

  up.holdingTargetAmount = up.holdingTargetAmount.plus(
    new BigDecimal(event.params.targetAmount).div(ETHER_DECIMAL)
  );

  up.save();
}

export function fetchUser(userAddr: Address): User {
  let user = User.load(userAddr);

  if (user == null) {
    user = new User(userAddr);
    user.address = userAddr;
  }
  user.save();

  return user;
}

export function fetchProduct(prodAddr: Address): Product {
  let product = Product.load(prodAddr);
  if (product == null) {
    product = new Product(prodAddr);
    product.address = prodAddr;

    const contract = SnowbowProduct.bind(prodAddr);

    product.startTime = contract._startTime();
    product.period = contract._period();
    product.targetToken = contract._targetToken();
    product.strikePrice = new BigDecimal(contract._targetInitPrice()).div(
      PRICE_DECIMAL_BIG_DECIMAL
    );
    product.knockInPrice = new BigDecimal(contract._targetKnockInPrice()).div(
      PRICE_DECIMAL_BIG_DECIMAL
    );
    product.knockOutPrice = new BigDecimal(contract._targetKnockOutPrice()).div(
      PRICE_DECIMAL_BIG_DECIMAL
    );

    product.yieldRate = new BigDecimal(
      BigInt.fromI32(contract._baseProfit())
    ).div(YIELD_RATE_DECIMAL_BIG_DECIMAL);

    product.knockIn = false;
    product.knockOut = false;
    product.result = "Invalid";
    product.latestPrice = BigDecimal.zero();
    product.latestPriceTimestamp = BigInt.zero();
  }

  product.save();

  return product;
}

export function fetchUserProduct(user: User, product: Product): UserProduct {
  const id = `${user.address.toHexString()}-${product.address.toHexString()}`;
  let up = UserProduct.load(id);

  if (up == null) {
    up = new UserProduct(id);
    up.user = user.id;
    up.product = product.id;
    up.holdingTargetAmount = BigDecimal.zero();

    up.save();
  }

  return up;
}
