import { BigDecimal } from "@graphprotocol/graph-ts";
import {
  KnockIn,
  KnockOut,
  PriceCheck,
  ProductStatusChange,
} from "../generated/PriceObserver/PriceObserver";
import { PRICE_DECIMAL_BIG_DECIMAL, fetchProduct } from "./snowbow-product";

export function handleKnockIn(event: KnockIn): void {
  const product = fetchProduct(event.params.product);
  product.knockIn = true;

  product.save();
}

export function handleKnockOut(event: KnockOut): void {
  const product = fetchProduct(event.params.product);
  product.knockOut = true;

  product.save();
}

export function handlePriceCheck(event: PriceCheck): void {
  const product = fetchProduct(event.params.product);

  product.latestPrice = new BigDecimal(event.params.currentPrice).div(
    PRICE_DECIMAL_BIG_DECIMAL
  );
  product.latestPriceTimestamp = event.block.timestamp;

  product.save();
}

export function handleProductStatus(event: ProductStatusChange): void {
  const product = fetchProduct(event.params.product);

  switch (event.params.currentStatus) {
    case 0:
      product.result = "Invalid";
      break;
    case 1:
      product.result = "NotEnd";
      break;
    case 2:
      product.result = "NorInOrOut";
      break;
    case 3:
      product.result = "InAndOut";
      break;
    case 4:
      product.result = "OnlyOut";
      break;
    case 5:
      product.result = "OnlyIn";
      break;
    default:
      break;
  }

  product.save();
}
