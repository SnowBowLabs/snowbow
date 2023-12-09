import { Address } from "@graphprotocol/graph-ts";
import {
  OwnershipHandoverCanceled as OwnershipHandoverCanceledEvent,
  OwnershipHandoverRequested as OwnershipHandoverRequestedEvent,
  OwnershipTransferred as OwnershipTransferredEvent,
  ProductCreate as ProductCreateEvent,
} from "../generated/SnowbowFactory/SnowbowFactory";
import { Product, User, UserProduct } from "../generated/schema";

export function handleProductCreate(event: ProductCreateEvent): void {
  // let entity = new ProductCreate(
  //   event.transaction.hash.concatI32(event.logIndex.toI32())
  // );
  // entity.param0 = event.params.param0;
  // entity.blockNumber = event.block.number;
  // entity.blockTimestamp = event.block.timestamp;
  // entity.transactionHash = event.transaction.hash;
  // entity.save();
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
  }
  product.save();

  return product;
}
